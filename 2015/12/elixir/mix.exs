defmodule Elixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [

    ]
  end

  defp deps do
    [
      {:json, "~> 1.4"}
    ]
  end
end
