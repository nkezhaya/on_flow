defmodule OnFlow.Factory do
  def create_account(credentials, keys \\ nil) do
    keys =
      case keys do
        %{public_key: _public_key} -> keys
        _ -> OnFlow.Credentials.generate_keys()
      end

    {:ok, address} = OnFlow.create_account(credentials, keys.public_key)

    address
  end

  defdelegate generate_keys, to: OnFlow.Credentials
end
