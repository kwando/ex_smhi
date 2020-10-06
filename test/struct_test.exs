defmodule StructTest do
  use ExUnit.Case

  test "error" do
    error = %ExSMHI.Error{message: "this is a message"}
    assert error.message == "this is a message"
  end

  test "Forecast.Parameter" do
    parameter = %ExSMHI.Forecast.Parameter{name: "wind", unit: "m/s", value: 12.1}

    expected_result =
      "#ExSMHI.Forecast.Parameter<name: \"wind\", unit: \"m/s\", value: 12.1, ...>"

    assert inspect(parameter) === expected_result
  end

  test "Forecast.TimeSerie" do
    series = %ExSMHI.Forecast.TimeSerie{validTime: ~U[2020-10-01T10:00:00Z]}

    expected_result = "#ExSMHI.Forecast.TimeSerie<validTime: ~U[2020-10-01 10:00:00Z], ...>"

    assert inspect(series) === expected_result
  end
end
