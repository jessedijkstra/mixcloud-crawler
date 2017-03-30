defmodule MixcloudCrawler do
  def main(station \\ []) do
    MixcloudCrawler.API.collection(station)
    |> Poison.encode!(pretty: true)
    |> IO.puts
  end
end
