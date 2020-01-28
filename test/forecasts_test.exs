defmodule ExSMHI.ForecastsTest do
  use ExUnit.Case, async: true

  @response File.read!("test/forecast.json")

  test "decoding" do
    assert {:ok, %ExSMHI.Forecast{} = forecast} = ExSMHI.ForecastDecoder.decode(@response)

    series =
      forecast
      |> ExSMHI.Forecast.extract_series("Wsymb2")

    assert is_list(series)
    assert [{%DateTime{}, 3} | _] = series
  end

  defp strip_parameters(time_series), do: %{time_series | parameters: nil}

  test "get timeseries by datetime" do
    assert {:ok, %ExSMHI.Forecast{} = forecast} = ExSMHI.ForecastDecoder.decode(@response)

    {:ok, serie} = ExSMHI.Forecast.forecast_for_time(forecast, ~U[2019-09-01T11:55:00Z])

    assert %ExSMHI.Forecast.TimeSerie{
             validTime: ~U[2019-09-01T11:00:00Z]
           } == strip_parameters(serie)

    assert {:ok, serie} = ExSMHI.Forecast.forecast_for_time(forecast, ~U[2019-09-01T08:32:00Z])

    assert %ExSMHI.Forecast.TimeSerie{
             validTime: ~U[2019-09-01T09:00:00Z]
           } == strip_parameters(serie),
           "it should return the first valid forecast"
  end

  test "get timeseries by datetime with invalid datetime" do
    assert {:ok, %ExSMHI.Forecast{} = forecast} = ExSMHI.ForecastDecoder.decode(@response)

    assert {:error, :out_of_range} ==
             ExSMHI.Forecast.forecast_for_time(forecast, ~U[2020-09-01T11:55:00Z])

    assert {:error, :out_of_range} ==
             ExSMHI.Forecast.forecast_for_time(forecast, ~U[2019-09-01T02:00:00Z])
  end
end
