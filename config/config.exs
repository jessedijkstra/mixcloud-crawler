# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :mixcloud_crawler, MixcloudCrawler.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "nts_repo",
  username: "postgres",
  password: "",
  hostname: "localhost"

config :mixcloud_crawler,
  ecto_repos: [MixcloudCrawler.Repo]

config :logger, :console, format: "[$level] $message\n"
