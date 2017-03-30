defmodule MixcloudCrawler.Mixfile do
  use Mix.Project

  def project do
    [app: :mixcloud_crawler,
     version: "0.1.0",
     elixir: "~> 1.4",
     escript: escript(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def escript, do: [
    main_module: MixcloudCrawler,
    path: "./build/mixcloud"
  ]

  def application do
    [ extra_applications: [:logger] ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.10"},
      {:poison, "~> 3.0"},
      {:hackney, "1.6.1", override: true}
    ]
  end
end
