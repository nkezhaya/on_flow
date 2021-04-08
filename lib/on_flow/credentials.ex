defmodule OnFlow.Credentials do
  @moduledoc """
  Defines a struct that contains an address, a public key, and a private key.

  `:address` might be `nil`, but the key will be present in the struct.

  Do not initialize this directly. Instead, call `Credentials.new/1` or
  `Credentials.new!/1`.
  """

  @enforce_keys [:address, :public_key, :private_key]
  defstruct [:address, :public_key, :private_key]

  @typep hex_string() :: String.t()

  @type keys_with_address() :: %{
          optional(:address) => nil | String.t(),
          required(:public_key) => String.t(),
          required(:private_key) => String.t()
        }

  @type t() :: %__MODULE__{
          address: nil | hex_string(),
          public_key: hex_string(),
          private_key: hex_string()
        }

  @doc """
  Initializes a `%Credentials{}` struct. Returns `{:ok, credentials}` on
  success. The params _must_ contain a `:private_key` and `:public_key`, or
  `{:error, :missing_keys}` will be returned.

  `:public_key` and `:private_key` must be hex-encoded strings.
  """
  @spec new(keys_with_address()) :: {:ok, t()} | {:error, :missing_keys}
  def new(attrs) do
    address = Map.get(attrs, :address)

    with public_key when is_binary(public_key) <- Map.get(attrs, :public_key),
         private_key when is_binary(private_key) <- Map.get(attrs, :private_key) do
      %__MODULE__{
        address: address,
        public_key: public_key,
        private_key: private_key
      }
    else
      _ -> {:error, :missing_keys}
    end
  end

  @doc """
  Initializes a `%Credentials{}` struct. Raises on error. See the documentation
  for `new/1`.
  """
  @spec new!(map()) :: t() | none()
  def new!(attrs) do
    case new(attrs) do
      {:ok, credentials} -> credentials
      _ -> raise OnFlow.MissingKeysError
    end
  end
end
