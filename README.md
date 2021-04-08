# OnFlow

OnFlow is an Elixir client for interacting with the Flow blockchain.
Documentation here: [https://hexdocs.pm/on_flow](https://hexdocs.pm/on_flow).

## Installation

Note that the GRPC and cowlib libraries are required:

```elixir
def deps do
  [
    {:on_flow, "~> 0.1"},
    {:grpc, github: "elixir-grpc/grpc"},
    {:cowlib, "~> 2.9", override: true}
  ]
end
```
