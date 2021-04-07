defmodule OnFlow.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OnFlow.Channel
    ]

    opts = [strategy: :one_for_one, name: OnFlow.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
