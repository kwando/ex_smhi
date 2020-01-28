defmodule ExSMHI.Utils do
  def format(pattern, bindings) do
    :io_lib.format(pattern, bindings)
    |> :erlang.iolist_to_binary()
  end
end
