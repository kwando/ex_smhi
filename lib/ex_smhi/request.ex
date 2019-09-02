defmodule ExSMHI.Request do
  defstruct [:method, :url, headers: [], body: nil, options: []]

  def get(url_or_path) do
    %__MODULE__{url: url_or_path, method: :GET}
  end
end
