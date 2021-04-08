defimpl ExRLP.Encode, for: OnFlow.Entities.Transaction do
  alias ExRLP.Encode

  @spec encode(OnFlow.Entities.Transaction.t(), keyword()) :: binary()
  def encode(%OnFlow.Entities.Transaction{} = transaction, options \\ []) do
    [
      transaction.script,
      transaction.arguments,
      transaction.reference_block_id,
      transaction.gas_limit,
      transaction.proposal_key.address,
      transaction.proposal_key.key_id,
      transaction.proposal_key.sequence_number,
      transaction.payer,
      transaction.authorizers
    ]
    |> Encode.encode(options)
  end
end

defimpl ExRLP.Encode, for: OnFlow.Entities.AccountKey do
  alias ExRLP.Encode

  @spec encode(OnFlow.Entities.AccountKey.t(), keyword()) :: binary()
  def encode(%OnFlow.Entities.AccountKey{} = account_key, options \\ []) do
    [
      account_key.public_key,
      account_key.sign_algo,
      account_key.hash_algo,
      account_key.weight
    ]
    |> Encode.encode(options)
  end
end
