defmodule ExSMHI.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_smhi,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
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
      {:hackney, ">= 0.0.0"},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:mix_test_watch, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  def package() do
    [
      licenses: ["MIT"],
      maintainers: ["Hannes Nevalainen"],
      description: "Get forecasts from the Swedish Meterology Institute",
      links: %{
        "GitHub" => "https://github.com/kwando/ex_smhi"
      }
    ]
  end
end
