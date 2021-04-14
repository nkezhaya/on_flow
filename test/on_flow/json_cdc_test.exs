defmodule OnFlow.JSONCDCTest do
  use ExUnit.Case, async: true
  import OnFlow.JSONCDC

  test "decode" do
    payload =
      "{\"type\":\"Event\",\"value\":{\"id\":\"A.f8d6e0586b0a20c7.SmartContract.Minted\",\"fields\":[{\"name\":\"id\",\"value\":{\"type\":\"UInt64\",\"value\":\"0\"}},{\"name\":\"nftID\",\"value\":{\"type\":\"String\",\"value\":\"c81aa9a6-a5c6-47a3-baf4-f8e73aaaea6f\"}}]}}\n"

    assert {:event, event} = decode!(payload)

    assert event == %{
             "id" => "A.f8d6e0586b0a20c7.SmartContract.Minted",
             "fields" => %{"id" => 0, "nftID" => "c81aa9a6-a5c6-47a3-baf4-f8e73aaaea6f"}
           }
  end
end
