defmodule ExSMHI do
  @moduledoc """
  Entry point for the ExSMHI library.
  """
  alias ExSMHI.{Forecasts, HTTP}

  def get_forecast(location) do
    location
    |> Forecasts.get_forecast()
    |> HTTP.request()
  end
end
