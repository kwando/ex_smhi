defmodule ExSMHI.HTTP.Request do
  defstruct [:method, :url, headers: [], body: nil, options: [], response_transforms: []]

  def get(url_or_path) do
    %__MODULE__{url: url_or_path, method: :GET}
  end

  def add_response_transform(request, transform) do
    %{request | response_transforms: [transform | request.response_transforms]}
  end

  defimpl Inspect, for: __MODULE__ do
    import Inspect.Algebra

    def inspect(request, _opts) do
      concat(["<HTTP.Request #{request.method} #{request.url}>"])
    end
  end
end
