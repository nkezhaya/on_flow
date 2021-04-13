defmodule OnFlow do
  import __MODULE__.Channel, only: [get_channel: 0]
  import __MODULE__.{Util, Transaction}

  alias __MODULE__.{Credentials, JSONCDC}

  @type account() :: OnFlow.Entities.Account.t()
  @type address() :: binary()
  @type error() :: {:error, GRPC.RPCError.t()}
  @type hex_string() :: String.t()
  @type transaction_result() ::
          {:ok | :error, OnFlow.Access.TransactionResultResponse.t()} | {:error, :timeout}

  @doc """
  Creates a Flow account. Note that an existing account must be passed in as the
  first argument, since internally this is executed as a transaction on the
  existing account.

  On success, it returns `{:ok, address}`, where `address` is a hex-encoded
  representation of the address.

  On failure, it returns `{:error, response}` or `{:error, :timeout}`.
  """
  @spec create_account(Credentials.t(), hex_string()) ::
          {:ok, hex_string()} | transaction_result()
  def create_account(%Credentials{} = credentials, public_key) do
    encoded_account_key =
      OnFlow.Entities.AccountKey.new(%{
        public_key: decode16(public_key),
        weight: 1000,
        sign_algo: 2,
        hash_algo: 3
      })
      |> ExRLP.encode(encoding: :hex)

    arguments = [
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

    send_transaction(render_create_account(), credentials,
      arguments: arguments,
      authorizers: credentials,
      payer: credentials
    )
    |> case do
      {:ok, %OnFlow.Access.TransactionResultResponse{events: events}} ->
        address =
          Enum.find_value(events, fn
            %{"address" => address, "id" => "flow.AccountCreated"} -> address
            _ -> false
          end)

        {:ok, trim_0x(address)}

      error ->
        error
    end
  end

  @doc """
  Deploys a contract to an account. This just takes in existing account
  credentials, the name of the contract, and the contract code. Internally, this
  is just a single-signer, single-authorizer transaction.

  Options:

    * `:update` - either `true` or `false` to update a previously deployed
    contract with the same name.
  """
  @spec deploy_contract(Credentials.t(), String.t(), String.t(), keyword()) ::
          transaction_result()
  def deploy_contract(%Credentials{} = credentials, name, contract, opts \\ []) do
    arguments = [
      %{"type" => "String", "value" => name},
      %{"type" => "String", "value" => encode16(contract)}
    ]

    case Keyword.fetch(opts, :update) do
      {:ok, update} when is_boolean(update) -> update
      :error -> false
    end
    |> case do
      true -> render_update_account_contract()
      false -> render_add_account_contract()
    end
    |> send_transaction(credentials,
      arguments: arguments,
      authorizers: credentials,
      payer: credentials
    )
  end

  @doc """
  Sends a transaction. Options:

    * `:args` - the list of objects that will be sent along with the
    transaction. This must be an Elixir list that can be encoded to JSON.
    * `:authorizers` - a list of authorizing `%Credentials{}` structs to
    authorize the transaction.
    * `:payer` - a hex-encoded address or `%Credentials{}` struct that will pay
    for the transaction.
    * `:wait_until_sealed` - either `true` or `false`. Note that if the
    transaction is not sealed after 30 seconds, this will return `{:error,
    :timeout}`. Defaults to `true`.
  """
  @spec send_transaction(String.t(), [Credentials.t()] | Credentials.t(), keyword()) ::
          transaction_result()
  def send_transaction(script, signers, opts \\ []) do
    signers = to_list(signers)
    authorizers = to_list(Keyword.get(opts, :authorizers, []))

    payer =
      case Keyword.get(opts, :payer) do
        %Credentials{address: address} -> address
        payer when is_binary(payer) -> payer
      end
      |> decode16()

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

    wait_until_sealed? =
      case Keyword.fetch(opts, :wait_until_sealed) do
        {:ok, wait_until_sealed} when is_boolean(wait_until_sealed) -> wait_until_sealed
        _ -> true
      end

    OnFlow.Entities.Transaction.new(%{
      arguments: parse_args(args),
      authorizers: authorizer_addresses,
      payer: payer,
      proposal_key: proposal_key,
      reference_block_id: get_latest_block_id(),
      script: script
    })
    |> maybe_sign_payload(signers)
    |> sign_envelope(signers)
    |> do_send_transaction(wait_until_sealed?)
  end

  defp to_list(list) when is_list(list), do: list
  defp to_list(item), do: [item]

  defp maybe_sign_payload(transaction, signers) when is_list(signers) do
    # Special case: if an account is both the payer and either a proposer or
    # authorizer, it is only required to sign the envelope.
    Enum.reduce(signers, transaction, fn signer, transaction ->
      decoded_address = decode16(signer.address)
      payer? = decoded_address == transaction.payer
      authorizer? = decoded_address in transaction.authorizers
      proposer? = decoded_address == transaction.proposal_key.address

      if payer? and (authorizer? or proposer?) do
        transaction
      else
        do_sign_payload(transaction, signer)
      end
    end)
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
    Enum.reduce(signers, transaction, fn signer, transaction ->
      sign_envelope(transaction, signer)
    end)
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
  defp do_send_transaction(transaction, wait_until_sealed?) do
    request = OnFlow.Access.SendTransactionRequest.new(%{transaction: transaction})
    response = OnFlow.Access.AccessAPI.Stub.send_transaction(get_channel(), request)

    with {:ok, %{id: id}} <- response, true <- wait_until_sealed? do
      do_get_sealed_transaction_result(encode16(id))
    else
      _ -> response
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

  @doc """
  Fetches the transaction result for a given transaction ID.
  """
  def get_transaction_result(id) do
    req = OnFlow.Access.GetTransactionRequest.new(%{id: decode16(id)})

    OnFlow.Access.AccessAPI.Stub.get_transaction_result(get_channel(), req)
  end

  defp do_get_sealed_transaction_result(id, num_attempts \\ 0)

  defp do_get_sealed_transaction_result(_id, n) when n > 30 do
    {:error, :timeout}
  end

  defp do_get_sealed_transaction_result(id, num_attempts) do
    case get_transaction_result(id) do
      {:ok, %OnFlow.Access.TransactionResultResponse{status: :SEALED} = response} ->
        events =
          Enum.map(response.events, fn event ->
            {:event, event} = JSONCDC.decode!(event.payload)
            event
          end)

        {:ok, %{response | events: events}}

      {:ok, %OnFlow.Access.TransactionResultResponse{status: _}} ->
        :timer.sleep(1000)

        do_get_sealed_transaction_result(id, num_attempts + 1)

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
      {:ok, %OnFlow.Access.ExecuteScriptResponse{value: response}} ->
        {:ok, Jason.decode!(response)}

      {:error, _} = result ->
        result
    end
  end

  defp parse_args(args) do
    for arg <- args, do: Jason.encode!(arg)
  end

  require EEx

  for template <- ~w(create_account add_account_contract update_account_contract)a do
    EEx.function_from_file(
      :defp,
      :"render_#{template}",
      "lib/on_flow/templates/#{template}.cdc.eex",
      []
    )
  end
end
