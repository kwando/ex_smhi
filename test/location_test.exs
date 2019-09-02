defmodule ExSMHI.LocationTest do
  use ExUnit.Case
  alias ExSMHI.Location

  test "new" do
    {:ok, %Location{latitude: 12.48, longitude: 112.32}} = Location.from({12.48, 112.32})
  end
end
