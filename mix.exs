defmodule OnFlow.MixProject do
  use Mix.Project

  def project do
    [
      app: :on_flow,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :eex],
      mod: {OnFlow.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grpc, github: "elixir-grpc/grpc"},
      {:cowlib, "~> 2.9", override: true},
      {:jason, ">= 0.0.0"},
      {:ex_rlp, ">= 0.0.0"}
    ]
  end
end
