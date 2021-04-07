defmodule OnFlow do
  import __MODULE__.Channel, only: [get_channel: 0]
  import __MODULE__.{Util, Transaction}

  @type account() :: Flow.Entities.Account.t()
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
          {:ok, hex_string()} | {:error, :timeout | Flow.Access.TransactionResultResponse.t()}
  def create_account(keys_with_address, public_key) do
    code = render_create_account()
    {:ok, existing_account} = get_account(keys_with_address.address)
    existing_account_key = hd(existing_account.keys)

    encoded_account_key =
      Flow.Entities.AccountKey.new(%{
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
      Flow.Entities.Transaction.ProposalKey.new(%{
        address: existing_account.address,
        key_id: existing_account_key.index,
        sequence_number: existing_account_key.sequence_number
      })

    Flow.Entities.Transaction.new(%{
      arguments: parse_args(args),
      authorizers: [decode16(keys_with_address.address)],
      payer: decode16(keys_with_address.address),
      proposal_key: proposal_key,
      reference_block_id: get_latest_block_id(),
      script: code
    })
    |> sign_envelope(keys_with_address)
    |> send_transaction()
    |> case do
      {:ok, %Flow.Access.TransactionResultResponse{events: events}} ->
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

  @doc false
  def sign_envelope(transaction, keys_with_address) do
    address = decode16(keys_with_address.address)
    private_key = decode16(keys_with_address.private_key)
    rlp = envelope_canonical_form(transaction)
    payer_signature = build_signature(address, private_key, rlp)
    signatures = transaction.envelope_signatures ++ [payer_signature]

    %{transaction | envelope_signatures: signatures}
  end

  @doc false
  def send_transaction(transaction) do
    request = Flow.Access.SendTransactionRequest.new(%{transaction: transaction})

    case Flow.Access.AccessAPI.Stub.send_transaction(get_channel(), request) do
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
      Flow.Access.AccessAPI.Stub.get_latest_block(
        get_channel(),
        Flow.Access.GetLatestBlockRequest.new()
      )

    latest_block_id
  end

  def get_transaction_result(id) do
    do_get_transaction_result(id)
  end

  defp do_get_transaction_result(id, num_attempts \\ 0)

  defp do_get_transaction_result(_id, n) when n > 10 do
    {:error, :timeout}
  end

  defp do_get_transaction_result(id, num_attempts) do
    req = Flow.Access.GetTransactionRequest.new(%{id: decode16(id)})

    Flow.Access.AccessAPI.Stub.get_transaction_result(get_channel(), req)
    |> case do
      {:ok, %Flow.Access.TransactionResultResponse{status: :SEALED}} = response ->
        response

      {:ok, %Flow.Access.TransactionResultResponse{status: _}} ->
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
    req = Flow.Access.GetAccountRequest.new(%{address: address})

    case Flow.Access.AccessAPI.Stub.get_account(get_channel(), req) do
      {:ok, %{account: account}} -> {:ok, account}
      error -> error
    end
  end

  def execute_script(code, args \\ []) do
    request =
      Flow.Access.ExecuteScriptAtLatestBlockRequest.new(%{
        arguments: parse_args(args),
        script: code
      })

    get_channel()
    |> Flow.Access.AccessAPI.Stub.execute_script_at_latest_block(request)
    |> case do
      {:ok, %Flow.Access.ExecuteScriptResponse{value: response}} -> {:ok, Jason.decode!(response)}
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
