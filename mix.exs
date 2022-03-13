defmodule OnFlow.MixProject do
  use Mix.Project

  @source_url "https://github.com/whitepaperclip/on_flow"

  def project do
    [
      app: :on_flow,
      version: "0.12.0",
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
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:dialyxir, "~> 1.1", only: :dev, runtime: false},
      {:grpc, ">= 0.0.0"},
      {:cowlib, ">= 0.0.0"},
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
        "lib/on_flow.ex",
        "lib/on_flow",
        "lib/google",
        "mix.exs",
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
