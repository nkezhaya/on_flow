defmodule OnFlow do
  import __MODULE__.Channel, only: [get_channel: 0]
  import __MODULE__.{Util, Transaction}

  @type account() :: OnFlow.Entities.Account.t()
  @type address() :: binary()
  @type error() :: {:error, GRPC.RPCError.t()}
  @type hex_string() :: String.t()

  @type keys_with_address() :: %{
          required(:address) => String.t(),
          required(:public_key) => String.t(),
          required(:private_key) => String.t()
        }

  def generate_keys do
    {pubkey, privkey} = :crypto.generate_key(:ecdh, :secp256r1)
    pubkey = encode16(pubkey)
    privkey = encode16(privkey)
    pubkey = String.replace_leading(pubkey, "04", "")

    %{public_key: pubkey, private_key: privkey}
  end

  @doc """
  Creates a Flow account. Note that an existing account must be passed in as the
  first argument, since internally this is executed as a transaction on the
  existing account.

  On success, it returns `{:ok, address}`, where `address` is a hex-encoded
  representation of the address.

  On failure, it returns `{:error, response}` or `{:error, :timeout}`.
  """
  @spec create_account(keys_with_address(), hex_string()) ::
          {:ok, hex_string()} | {:error, :timeout | OnFlow.Access.TransactionResultResponse.t()}
  def create_account(keys_with_address, public_key) do
    code = render_create_account()
    {:ok, existing_account} = get_account(keys_with_address.address)
    existing_account_key = hd(existing_account.keys)

    encoded_account_key =
      OnFlow.Entities.AccountKey.new(%{
        public_key: decode16(public_key),
        weight: 1000,
        sign_algo: 2,
        hash_algo: 3
      })
      |> ExRLP.encode(encoding: :hex)

    args = [
      %{
        type: "Array",
        value: [
          %{
            type: "String",
            value: encoded_account_key
          }
        ]
      },
      %{type: "Dictionary", value: []}
    ]

    proposal_key =
      OnFlow.Entities.Transaction.ProposalKey.new(%{
        address: existing_account.address,
        key_id: existing_account_key.index,
        sequence_number: existing_account_key.sequence_number
      })

    OnFlow.Entities.Transaction.new(%{
      arguments: parse_args(args),
      authorizers: [decode16(keys_with_address.address)],
      payer: decode16(keys_with_address.address),
      proposal_key: proposal_key,
      reference_block_id: get_latest_block_id(),
      script: code
    })
    |> sign_envelope(keys_with_address)
    |> do_send_transaction()
    |> case do
      {:ok, %OnFlow.Access.TransactionResultResponse{events: events}} ->
        account_created_event = Enum.find(events, &(&1.type == "flow.AccountCreated"))

        %{
          "type" => "Event",
          "value" => %{
            "fields" => [
              %{"name" => "address", "value" => %{"type" => "Address", "value" => address}}
            ]
          }
        } = Jason.decode!(account_created_event.payload)

        {:ok, trim_0x(address)}

      error ->
        error
    end
  end

  @doc """
  Sends a transaction.
  """
  @spec send_transaction(
          String.t(),
          [keys_with_address()] | keys_with_address(),
          [keys_with_address()] | keys_with_address(),
          address(),
          keyword()
        ) ::
          {:ok | :error, OnFlow.Access.TransactionResultResponse.t()} | {:error, :timeout}
  def send_transaction(script, signers, authorizers, payer, opts \\ []) do
    signers = to_list(signers)
    authorizers = to_list(authorizers)

    if signers == [] do
      raise "You must provide at least one signer"
    end

    if payer not in Enum.map(authorizers, &decode16(&1.address)) do
      raise "Payer address #{inspect(payer)} not found in the list of authorizers."
    end

    # Set the proposal key. This is just the account that lends its sequence
    # number to the transaction.
    {:ok, %{keys: [proposer_key | _]} = proposer} = get_account(hd(signers).address)

    proposal_key =
      OnFlow.Entities.Transaction.ProposalKey.new(%{
        address: proposer.address,
        key_id: proposer_key.index,
        sequence_number: proposer_key.sequence_number
      })

    authorizer_addresses = for a <- authorizers, do: decode16(a.address)

    args = Keyword.get(opts, :arguments, [])

    OnFlow.Entities.Transaction.new(%{
      arguments: parse_args(args),
      authorizers: authorizer_addresses,
      payer: decode16(payer),
      proposal_key: proposal_key,
      reference_block_id: get_latest_block_id(),
      script: script
    })
    |> maybe_sign_payload(signers)
    |> sign_envelope(signers)
    |> do_send_transaction()
  end

  defp to_list(list) when is_list(list), do: list
  defp to_list(item), do: [item]

  defp maybe_sign_payload(transaction, signers) when is_list(signers) do
    Enum.map(signers, &sign_payload(transaction, &1))
  end

  # Special case: if an account is both the payer and either a proposer or
  # authorizer, it is only required to sign the envelope.
  defp sign_payload(transaction, signer) do
    decoded_address = decode16(signer.address)
    payer? = decoded_address == transaction.payer
    authorizer? = decoded_address in transaction.authorizers
    proposer? = decoded_address == transaction.proposal_key.address

    if payer? and (authorizer? or proposer?) do
      transaction
    else
      do_sign_payload(transaction, signer)
    end
  end

  defp do_sign_payload(transaction, signer) do
    address = decode16(signer.address)
    private_key = decode16(signer.private_key)
    rlp = payload_canonical_form(transaction)
    signer_signature = build_signature(address, private_key, rlp)
    signatures = transaction.payload_signatures ++ [signer_signature]

    %{transaction | payload_signatures: signatures}
  end

  defp sign_envelope(transaction, signers) when is_list(signers) do
    Enum.map(signers, &sign_envelope(transaction, &1))
  end

  defp sign_envelope(transaction, signer) do
    address = decode16(signer.address)
    private_key = decode16(signer.private_key)
    rlp = envelope_canonical_form(transaction)
    signer_signature = build_signature(address, private_key, rlp)
    signatures = transaction.envelope_signatures ++ [signer_signature]

    %{transaction | envelope_signatures: signatures}
  end

  @doc false
  defp do_send_transaction(transaction) do
    request = OnFlow.Access.SendTransactionRequest.new(%{transaction: transaction})

    case OnFlow.Access.AccessAPI.Stub.send_transaction(get_channel(), request) do
      {:ok, %{id: id}} -> get_transaction_result(encode16(id))
      error -> error
    end
  end

  @doc """
  Returns a binary of the latest block ID. This is typically used as a reference
  ID when sending transactions to the network.
  """
  def get_latest_block_id do
    {:ok, %{block: %{id: latest_block_id}}} =
      OnFlow.Access.AccessAPI.Stub.get_latest_block(
        get_channel(),
        OnFlow.Access.GetLatestBlockRequest.new()
      )

    latest_block_id
  end

  def get_transaction_result(id) do
    do_get_transaction_result(id)
  end

  defp do_get_transaction_result(id, num_attempts \\ 0)

  defp do_get_transaction_result(_id, n) when n > 20 do
    {:error, :timeout}
  end

  defp do_get_transaction_result(id, num_attempts) do
    req = OnFlow.Access.GetTransactionRequest.new(%{id: decode16(id)})

    OnFlow.Access.AccessAPI.Stub.get_transaction_result(get_channel(), req)
    |> case do
      {:ok, %OnFlow.Access.TransactionResultResponse{status: :SEALED}} = response ->
        response

      {:ok, %OnFlow.Access.TransactionResultResponse{status: _}} ->
        :timer.sleep(1000)
        do_get_transaction_result(id, num_attempts + 1)

      error ->
        error
    end
  end

  @doc """
  Executes a script on the Flow network to show account data.
  """
  @spec get_account(address()) :: {:ok, account()} | error()
  def get_account(address) do
    address = decode16(address)
    req = OnFlow.Access.GetAccountRequest.new(%{address: address})

    case OnFlow.Access.AccessAPI.Stub.get_account(get_channel(), req) do
      {:ok, %{account: account}} -> {:ok, account}
      error -> error
    end
  end

  def execute_script(code, args \\ []) do
    request =
      OnFlow.Access.ExecuteScriptAtLatestBlockRequest.new(%{
        arguments: parse_args(args),
        script: code
      })

    get_channel()
    |> OnFlow.Access.AccessAPI.Stub.execute_script_at_latest_block(request)
    |> case do
      {:ok, %OnFlow.Access.ExecuteScriptResponse{value: response}} -> {:ok, Jason.decode!(response)}
      {:error, _} = result -> result
    end
  end

  defp parse_args(args) do
    for arg <- args, do: Jason.encode!(arg)
  end

  require EEx

  EEx.function_from_file(
    :defp,
    :render_create_account,
    "lib/on_flow/templates/create_account.cdc.eex",
    []
  )
end
