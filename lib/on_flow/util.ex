defmodule OnFlow.Util do
  @doc """
  Encodes the given binary to a hex string.

      iex> encode16("")
      ""

      iex> encode16("foo")
      "666f6f"
  """
  @spec encode16(binary()) :: String.t()
  def encode16(key), do: Base.encode16(key, case: :lower)

  @doc """
  Decodes the given hex string to a binary. Also accepts hex strings prefixed by
  "0x" for convenience.

      iex> decode16("")
      ""

      iex> decode16("666f6f")
      "foo"

      iex> decode16("0x666f6f")
      "foo"

      iex> decode16("0X666f6f")
      "foo"

      iex> decode16("0X666f6F")
      "foo"
  """
  @spec decode16(String.t()) :: binary()
  def decode16("0x" <> address), do: decode16(address)
  def decode16("0X" <> address), do: decode16(address)
  def decode16(key), do: Base.decode16!(key, case: :mixed)

  @doc """
  Trims "0x" off the given string.

      iex> trim_0x("")
      ""

      iex> trim_0x("666f6f")
      "666f6f"

      iex> trim_0x("0x666f6f")
      "666f6f"

      iex> trim_0x("0X666f6f")
      "666f6f"
  """
  @spec trim_0x(String.t()) :: String.t()
  def trim_0x("0x" <> bin), do: bin
  def trim_0x("0X" <> bin), do: bin
  def trim_0x(bin), do: bin

  @doc """
  Pads a given binary or list of binaries with null bytes until the given binary
  reaches the given byte size. `direction` can be either `:left` or `:right`,
  but defaults to `:left`.

  If `count` is not a positive integer, the binary is returned unchanged.

      iex> pad(<<91, 77>>, 4)
      <<0, 0, 91, 77>>

      iex> pad(<<91, 77>>, 4, :right)
      <<91, 77, 0, 0>>

      iex> pad([<<91, 77>>, <<129>>], 4, :right)
      [<<91, 77, 0, 0>>, <<129, 0, 0, 0>>]

      iex> pad([<<91, 77>>, <<129>>], 0)
      [<<91, 77>>, <<129>>]
  """
  @spec pad(binary() | [binary()], integer(), :left | :right) :: binary()
  def pad(list, count, direction \\ :left)

  def pad(list, count, direction) when is_list(list) do
    for item <- list, do: pad(item, count, direction)
  end

  def pad(bin, count, _direction) when count <= 0, do: bin
  def pad("", _count, _direction), do: ""
  def pad(bin, count, :left), do: :binary.copy(<<0>>, count - byte_size(bin)) <> bin
  def pad(bin, count, :right), do: bin <> :binary.copy(<<0>>, count - byte_size(bin))
end
