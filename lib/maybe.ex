defmodule Maybe do
  def and_then(nil, _), do: nil
  def and_then(val,fnc), do: fnc.(val)

  def with_default(nil, fnc) when is_function(fnc), do: fnc.()
  def with_default(nil, default), do: default
  def with_default(val, _), do: val 
end
