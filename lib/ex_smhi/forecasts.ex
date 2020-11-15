defmodule ExSMHI.Forecasts do
  @moduledoc """
  High level functions for fething forecasts.
  """
  alias ExSMHI.HTTP.Request
  alias ExSMHI.Utils
  @base_url "https://opendata-download-metfcst.smhi.se"
  def get_forecast(location) do
    {:ok, loc} = ExSMHI.Location.from(location)

    "~s/api/category/pmp3g/version/2/geotype/point/lon/~.6f/lat/~.6f/data.json"
    |> Utils.format([@base_url, loc.longitude, loc.latitude])
    |> Request.get()
    |> Request.add_response_transform(:extract_body)
    |> Request.add_response_transform(fn body ->
      {:ok, forecast} = ExSMHI.ForecastDecoder.decode(body)
      forecast
    end)
  end

  def get_valid_time(opts \\ []) do
    version = Keyword.get(opts, :version, 2)
    category = Keyword.get(opts, :category, "pmp3g")

    "#{@base_url}/api/category/#{category}/version/#{version}/validtime.json"
    |> Request.get()
    |> Request.add_response_transform(:decode_json)
    |> Request.add_response_transform(&parse_validtime/1)
  end

  defp parse_timestamp(timestamp) do
    {:ok, datetime, 0} = DateTime.from_iso8601(timestamp)
    datetime
  end

  defp parse_validtime({200, _, %{"validTime" => times}}) do
    Enum.map(times, &parse_timestamp/1)
  end
end
