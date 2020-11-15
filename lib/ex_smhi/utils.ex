defmodule ExSMHI.Utils do
  @moduledoc """
  Utility function.
  """

  @doc """
  Formats a string according to an pattern
  """
  def format(pattern, bindings) do
    :erlang.iolist_to_binary(:io_lib.format(pattern, bindings))
  end
end
