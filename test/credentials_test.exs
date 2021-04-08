defmodule OnFlow.CredentialsTest do
  use ExUnit.Case
  import OnFlow.Util
  alias OnFlow.Credentials

  test "missing keys" do
    assert {:error, :missing_keys} = Credentials.new(%{})
    assert {:error, :missing_keys} = Credentials.new(%{public_key: nil, private_key: nil})
    assert {:error, :missing_keys} = Credentials.new(%{public_key: nil, private_key: nil})

    assert_raise OnFlow.MissingKeysError, fn ->
      Credentials.new!(%{})
    end
  end

  test "credentials" do
    credentials = Credentials.generate_keys()

    # These must be hex-encoded
    assert is_nil(credentials.address)
    assert decode16(credentials.public_key)
    assert decode16(credentials.private_key)

    assert new_credentials =
             Credentials.new!(%{
               public_key: credentials.public_key,
               private_key: credentials.private_key
             })

    assert is_nil(new_credentials.address)
    assert new_credentials.private_key == credentials.private_key
    assert new_credentials.public_key == credentials.public_key
  end
end
