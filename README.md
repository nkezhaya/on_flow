# OnFlow

OnFlow is an Elixir client for interacting with the Flow blockchain.
Documentation here: [https://hexdocs.pm/on_flow](https://hexdocs.pm/on_flow).

## Installation

Note that the GRPC and cowlib libraries are required. As of the time of writing,
the latest versions of these packages are not published to hex. To avoid
dependency errors, you should include them both and add `override: true` to your
`mix.exs`.

```elixir
def deps do
  [
    {:on_flow, "~> 0.3"},
    {:grpc, github: "elixir-grpc/grpc", override: true},
    {:cowlib, "~> 2.9", override: true}
  ]
end
```

## Configuration

Point OnFlow to the GRPC server by adding the following to your
`config/config.exs`:

```elixir
config :on_flow, host: "access.testnet.nodes.onflow.org:9000"
```

Replace the `:host` value with the location of the server you're using. Be sure
to use the production server in your `config/prod.exs` if applicable.
