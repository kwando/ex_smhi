defmodule ExSMHI.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_smhi,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, ">= 0.0.0"},
      {:mint, ">= 0.0.0"},
      {:mix_test_watch, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
