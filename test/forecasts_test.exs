defmodule ExSMHI.ForecastsTest do
  use ExUnit.Case, async: true

  @tag :skip
  test "get_forecast" do
    assert {:ok, result} = ExSMHI.Forecasts.get_forecast({55.596, 13.023})
  end

  @response File.read!("test/forecast.json")

  test "decoding" do
    assert {:ok, %ExSMHI.Forecast{} = forecast} = ExSMHI.ForecastDecoder.decode(@response)

    series =
      forecast
      |> ExSMHI.Forecast.extract_series("Wsymb2")

    assert is_list(series)
    assert [{%DateTime{}, 3} | _] = series
  end
end
