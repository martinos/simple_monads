defmodule Result do
  def map({:error, result}, _), do: {:error, result}
  def map({:ok, val}, fnc), do: {:ok, fnc.(val)}
  def and_then({:error, result}, _fnc), do: {:error, result}

  def and_then({:ok, result}, fnc) do
    case fnc.(result) do
      {:ok, result} ->
        {:ok, result}

      {:error, result} ->
        {:error, result}

      result ->
        raise "Invalid return value #{result} for the function passed to the and_then Result"
    end
  end

  def map_error(result = {:ok, _}, _), do: result
  def map_error({:error, val}, fnc) when is_function(fnc), do: {:error, fnc.(val)}
  def map_error({:error, _}, new_error), do: {:error, new_error}

  def from_maybe(nil, error), do: {:error, error}
  def from_maybe(val, _fnc), do: {:ok, val}
end
