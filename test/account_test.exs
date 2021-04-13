defmodule OnFlow.AccountTest do
  use OnFlow.DataCase

  test "create account", %{credentials: credentials} do
    %{public_key: public_key} = OnFlow.Credentials.generate_keys()

    {:ok, address} = OnFlow.create_account(credentials, public_key)

    assert {:ok, account} = OnFlow.get_account(address)

    assert encode16(account.address) == address
    assert [key] = account.keys
    assert encode16(key.public_key) == public_key
  end
end
