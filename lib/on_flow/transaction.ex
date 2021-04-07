defmodule OnFlow.Transaction do
  import OnFlow.Util
  alias OnFlow.Crypto

  def build_signature(address, private_key, index \\ 0, msg) do
    Flow.Entities.Transaction.Signature.new(%{
      address: address,
      key_id: index,
      signature: Crypto.sign(msg, private_key)
    })
  end

  def payload(transaction) do
    [
      transaction.script,
      transaction.arguments,
      pad(transaction.reference_block_id, 32),
      transaction.gas_limit,
      pad(transaction.proposal_key.address, 8),
      transaction.proposal_key.key_id,
      transaction.proposal_key.sequence_number,
      pad(transaction.payer, 8),
      pad(transaction.authorizers, 8)
    ]
  end

  def payload_canonical_form(transaction) do
    transaction
    |> payload()
    |> ExRLP.encode()
  end

  # Signatures aren't encoded normally. Instead of encoding the `address` field
  # on the actual signature object, we have to encode the index instead.
  def envelope_canonical_form(transaction) do
    signatures =
      for {signature, i} <- Enum.with_index(transaction.payload_signatures) do
        [i, signature.key_id, signature.signature]
      end

    [payload(transaction), signatures]
    |> ExRLP.encode()
  end
end
