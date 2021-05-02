defmodule OnFlow.DataCase do
  defmacro __using__(_) do
    quote do
      use ExUnit.Case
      import OnFlow.Util
      import OnFlow.Factory

      setup do
        start_supervised(OnFlow.Emulator)
        :ok
      end

      setup do
        service_credentials =
          OnFlow.Credentials.new!(%{
            address: "f8d6e0586b0a20c7",
            private_key: "d436bf5de20f752f1dfc709430c1164b8bf6fdb0f9564c1d6488885dd3513706",
            public_key:
              "29d522b60bfb1ed1ccd9fb846295c4e25a8796a6e3de9da2100a6fceb353d86ae88688086c1817659c230fd589608da610eab24d3cb037b62cedb317b723c6f1"
          })

        [credentials: service_credentials]
      end
    end
  end
end
