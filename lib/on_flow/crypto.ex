defmodule OnFlow.Crypto do
  use Bitwise

  @doc """
  Signs the message with the given private key. Options are:

    * `:hash`, which defaults to `:sha3_256`
    * `:sign`, which defaults to `:secp256r1`
  """
  def sign(msg, private_key, opts \\ []) do
    msg
    |> signature(private_key, opts)
    |> rs_pair()
  end

  @doc false
  def signature(msg, private_key, opts) do
    hash = Keyword.get(opts, :hash, :sha3_256)
    sign = Keyword.get(opts, :sign, :secp256r1)

    :crypto.sign(:ecdsa, hash, msg, [private_key, sign])
  end

  @doc false
  def rs_pair(signature) do
    at = fn index ->
      <<n>> = binary_part(signature, index, 1)
      n
    end

    start_r = if (at.(1) &&& 0x80) != 0, do: 3, else: 2
    length_r = at.(start_r + 1)
    start_s = start_r + 2 + length_r
    length_s = at.(start_s + 1)

    r = binary_part(signature, start_r + 2, length_r)
    s = binary_part(signature, start_s + 2, length_s)

    r = String.trim_leading(r, <<0>>)
    s = String.trim_leading(s, <<0>>)

    r <> s
  end
end
