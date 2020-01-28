defmodule EXSMHITest do
  use ExUnit.Case
  doctest ExSMHI
  alias ExSMHI.Forecast

  test "getting forecast" do
    {:ok, %Forecast{}} = ExSMHI.get_forecast(:malmö)
  end
end
