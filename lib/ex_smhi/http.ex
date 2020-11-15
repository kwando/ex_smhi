defmodule ExSMHI.HTTP do
  alias ExSMHI.HTTP
  require Logger

  @moduledoc """
  Interface for doing HTTP requests
  """

  def request(%HTTP.Request{} = request, _opts \\ []) do
    Logger.debug("executing request #{inspect(request)}")

    with {:ok, status, headers, client} <- :hackney.request(request.method, request.url) do
      {:ok, body} = :hackney.body(client)
      response = {status, headers, body}

      case status do
        200 ->
          response = transform_response(response, request.response_transforms)
          {:ok, response}

        _ ->
          {:error, {:http_error, response, request}}
      end
    end
  end

  defp transform_response(response, []), do: response

  defp transform_response(response, [transform | transforms]),
    do: handle_transform(transform, transform_response(response, transforms))

  defp handle_transform(:decode_json, {status, headers, body}) do
    with {:ok, body} <- Jason.decode(body) do
      {status, headers, body}
    end
  end

  defp handle_transform(:extract_body, {_, _headers, body}) do
    body
  end

  defp handle_transform(fun, response) when is_function(fun, 1) do
    fun.(response)
  end
end
