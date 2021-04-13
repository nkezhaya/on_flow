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
            private_key: "24523ed355d87bbf98e53cd1761892b09f06669f5751a23dfa9d6318650f08d5",
            public_key:
              "573d4d760d17c10c9f84879a4ebbcdd36a457d84764da2b1cfa7b1db1c59e7645d6ad97f92ab67fd2802fc5a3d7e5e1fee30f73916f0aa873ab7fd697f39e227"
          })

        [credentials: service_credentials]
      end
    end
  end
end
