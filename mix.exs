defmodule OnFlow.MixProject do
  use Mix.Project

  @source_url "https://github.com/whitepaperclip/on_flow"

  def project do
    [
      app: :on_flow,
      version: "0.1.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

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

  defp description do
    """
    OnFlow is an Elixir client for interacting with the Flow blockchain.
    """
  end

  defp package do
    [
      name: :on_flow,
      files: [
        "assets",
        "lib/on_flow.ex",
        "lib/on_flow",
        "mix.exs",
        "package.json",
        "README.md",
        "LICENSE"
      ],
      maintainers: ["Nick Kezhaya"],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      main: "OnFlow",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end
end
