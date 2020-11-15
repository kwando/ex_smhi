defmodule ExSMHI.Location do
  @moduledoc """
  Representation of a location.
  """
  defstruct [:latitude, :longitude]

  def from({latitude, longitude}) when is_number(latitude) and is_number(longitude) do
    {:ok, %__MODULE__{longitude: longitude, latitude: latitude}}
  end

  def from(:malmö) do
    {:ok, %__MODULE__{latitude: 55.5700886, longitude: 12.8758906}}
  end

  def from(input) do
    {:error, {:invalid_location, input}}
  end
end
