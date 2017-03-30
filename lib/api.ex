defmodule MixcloudCrawler.API do
  use HTTPoison.Base

  def cloudcasts(station) do
    get!(
      "https://api.mixcloud.com/#{station}/cloudcasts/?limit=9999",
      [],
      hackney: [:insecure, follow_redirect: true]
    ).body
    |> Map.get("data")
  end

  def streams(station) do
    cloudcasts(station)
    |> Enum.map(&(Map.get(&1, "key")))
  end

  def collection(station) do
    Enum.flat_map(
      streams(station),
      fn(stream_id)->
        get!(
          "https://www.mixcloud.com/player/details/?key=#{stream_id}",
          [],
          hackney: [:insecure, follow_redirect: true]
        )
        |> Map.get(:body)
        |> Map.get("cloudcast")
        |> Map.get("sections")
        |> Enum.filter(fn(entry)->
          artist = Map.get(entry, "artist")
          title = Map.get(entry, "title")

          artist &&
          title &&
          String.first(artist) &&
          String.first(title)
        end)
      end
    )
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
  end
end
