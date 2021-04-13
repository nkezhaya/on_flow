defmodule OnFlow.ContractTest do
  use OnFlow.DataCase

  test "deploy a contract to an account", %{credentials: credentials} do
    contract = """
    access(all) contract HelloWorld {
      access(all) let greeting: String

      init() {
        self.greeting = "Hello, World!"
      }

      access(all) fun hello(): String {
        return self.greeting
      }
    }
    """

    keys = generate_keys()
    address = create_account(credentials, keys)
    keys = %{keys | address: address}
    {:ok, account} = OnFlow.get_account(address)

    assert %{} == account.contracts

    {:ok, response} = OnFlow.deploy_contract(keys, "HelloWorld", contract)

    assert Enum.find(response.events, fn
             {:event, %{"id" => "flow.AccountContractAdded"}} -> true
             _ -> false
           end)

    {:ok, account} = OnFlow.get_account(address)
    assert %{"HelloWorld" => _} = account.contracts
  end
end
