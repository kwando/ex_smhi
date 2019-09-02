defmodule ExSMHI.ForecastDecoder do
  def decode(binary) do
    with {:ok, data} = Jason.decode(binary) do
      forecast = %ExSMHI.Forecast{
        approvedTime: timestamp(data["approvedTime"]),
        referenceTime: timestamp(data["referenceTime"]),
        geometry: geometry(data["geometry"]),
        timeSeries: timeseries(data["timeSeries"])
      }

      {:ok, forecast}
    end
  end

  defp timestamp(value) do
    {:ok, timestamp, 0} = DateTime.from_iso8601(value)
    timestamp
  end

  defp geometry(%{"type" => "Point", "coordinates" => [[longitude, latitude]]}) do
    %ExSMHI.Location{longitude: longitude, latitude: latitude}
  end

  defp timeseries(series) do
    for serie <- series do
      %ExSMHI.Forecast.TimeSerie{
        validTime: timestamp(serie["validTime"]),
        parameters: parameters(serie["parameters"])
      }
    end
  end

  defp parameters(parameters) do
    for parameter <- parameters do
      %ExSMHI.Forecast.Parameter{
        name: parameter["name"],
        levelType: parameter["levelType"],
        level: parameter["level"],
        unit: parameter["unit"],
        values: parameter["values"]
      }
    end
  end
end
