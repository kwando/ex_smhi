defmodule ExSMHI do
  alias ExSMHI.{Forecasts, HTTP}

  def get_forecast(location) do
    location
    |> Forecasts.get_forecast()
    |> HTTP.request()
  end
end
