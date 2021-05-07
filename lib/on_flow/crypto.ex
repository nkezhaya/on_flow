defmodule OnFlow.Crypto do
  use Bitwise

  @doc """
  Generates a key pair.
  """
  @spec generate_keys() :: %{public_key: String.t(), private_key: String.t()}
  def generate_keys do
    {<<4>> <> public_key, private_key} = :crypto.generate_key(:ecdh, :secp256r1)
    public_key = Base.encode16(public_key, case: :lower)
    private_key = Base.encode16(private_key, case: :lower)

    %{public_key: public_key, private_key: private_key}
  end

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

    start_r = if (at.(1) &&& 0x80) == 1, do: 3, else: 2
    length_r = at.(start_r + 1)
    start_s = start_r + 2 + length_r
    length_s = at.(start_s + 1)

    r = binary_part(signature, start_r + 2, length_r)
    s = binary_part(signature, start_s + 2, length_s)

    # 256 >> 3
    n = 32
    final_signature = :binary.copy(<<0>>, n * 2)

    offset_r = max(n - byte_size(r), 0)
    start_r = max(0, byte_size(r) - n)
    final_signature = copy_into(final_signature, r, offset_r, start_r)

    offset_s = max(2 * n - byte_size(s), n)
    start_s = max(0, byte_size(s) - n)
    final_signature = copy_into(final_signature, s, offset_s, start_s)

    final_signature
  end

  @doc false
  def copy_into(destination, src, destination_offset \\ 0, start_index \\ 0) do
    destination = :binary.bin_to_list(destination)
    {prefix, destination} = :lists.split(destination_offset, destination)

    src = :binary.bin_to_list(src)
    {_, src} = :lists.split(start_index, src)

    {_replaced, destination} = :lists.split(length(src), destination)

    :binary.list_to_bin(prefix ++ src ++ destination)
  end
end
