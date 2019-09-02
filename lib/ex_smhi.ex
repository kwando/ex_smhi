defmodule ExSMHI do
  defmodule Location do
    defstruct [:latitude, :longitude]

    def from({latitude, longitude}) when is_number(latitude) and is_number(longitude) do
      {:ok, %__MODULE__{longitude: longitude, latitude: latitude}}
    end

    def from(input) do
      {:error, {:invalid_location, input}}
    end
  end
end
