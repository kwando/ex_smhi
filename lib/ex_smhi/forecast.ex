defmodule ExSMHI.Forecast do
  defstruct [:approvedTime, :referenceTime, :geometry, :timeSeries]

  defmodule TimeSerie do
    @derive {Inspect, only: [:validTime]}
    defstruct [:validTime, :parameters]
  end

  defmodule Parameter do
    @derive {Inspect, only: [:name, :value, :unit]}
    defstruct [:name, :levelType, :level, :unit, :value]
  end

  def extract_series(%{timeSeries: series}, name, opts \\ []) do
    parameter_mapper = Keyword.get(opts, :mapper, fn %{value: v} -> v end)

    Enum.reduce(series, [], fn serie, acc ->
      param = serie.parameters |> Enum.find(fn p -> p.name == name end)
      [{serie.validTime, parameter_mapper.(param)} | acc]
    end)
    |> Enum.reverse()
  end

  def precipitation_category(0), do: "No precipitation"
  def precipitation_category(1), do: "Snow"
  def precipitation_category(2), do: "Snow and rain"
  def precipitation_category(3), do: "Rain"
  def precipitation_category(4), do: "Drizzle"
  def precipitation_category(5), do: "Freezing rain"
  def precipitation_category(6), do: "Freezing drizzle"

  wheatherSumbols = [
    {1, "Clear sky"},
    {2, "Nearly clear sky"},
    {3, "Variable cloudiness"},
    {4, "Halfclear sky"},
    {5, "Cloudy sky"},
    {6, "Overcast"},
    {7, "Fog"},
    {8, "Light rain showers"},
    {9, "Moderate rain showers"},
    {10, "Heavy rain showers"},
    {11, "Thunderstorm"},
    {12, "Light sleet showers"},
    {13, "Moderate sleet showers"},
    {14, "Heavy sleet showers"},
    {15, "Light snow showers"},
    {16, "Moderate snow showers"},
    {17, "Heavy snow showers"},
    {18, "Light rain"},
    {19, "Moderate rain"},
    {20, "Heavy rain"},
    {21, "Thunder"},
    {22, "Light sleet"},
    {23, "Moderate sleet"},
    {24, "Heavy sleet"},
    {25, "Light snowfall"},
    {26, "Moderate snowfall"},
    {27, "Heavy snowfall"}
  ]

  for {id, symbol} <- wheatherSumbols do
    def weather_symbol(unquote(id)) do
      unquote(symbol)
    end
  end

  def forecast_for_time(%__MODULE__{timeSeries: series} = forecast, datetime) do
    first = hd(series)

    DateTime.compare(forecast.referenceTime, datetime)
    |> case do
      :lt ->
        DateTime.compare(first.validTime, datetime)
        |> case do
          :gt ->
            {:ok, first}

          _ ->
            find_series(series, datetime)
        end

      :gt ->
        {:error, :out_of_range}
    end
  end

  def current_forecast(forecast) do
    forecast
    |> forecast_for_time(DateTime.utc_now())
  end

  defp find_series([a, b | rest], datetime) do
    if(
      DateTime.compare(a.validTime, datetime) == :lt and
        DateTime.compare(b.validTime, datetime) !== :lt
    ) do
      {:ok, a}
    else
      find_series([b | rest], datetime)
    end
  end

  defp find_series([], _), do: {:error, :out_of_range}
  defp find_series([_], _), do: {:error, :out_of_range}
end
