defmodule ExSMHI.Forecasts do
  alias ExSMHI.Request
  @baseUrl "https://opendata-download-metfcst.smhi.se"
  def get_forecast(location) do
    {:ok, loc} = ExSMHI.Location.from(location)

    Request.get(
      "#{@baseUrl}/api/category/pmp3g/version/2/geotype/point/lon/#{loc.longitude}/lat/#{
        loc.latitude
      }/data.json"
    )
  end

  def get_valid_time(opts \\ []) do
    version = Keyword.get(opts, :version, 2)
    category = Keyword.get(opts, :category, "pmp3g")
    Request.get("#{@baseUrl}/api/category/#{category}/version/#{version}/validtime.json")
  end
end
