defmodule MaybeTest do
  use ExUnit.Case
  import Maybe

  test "and_then should return nil if nil is passed as first arg" do
    refute nil |> map(fn -> 3 end)
  end

  test "passes the first args to the function and return the returned val" do
    assert 4 |> map(fn a -> a + 8 end) == 12
  end

  test "sets the a default value when one result in the chain is nil" do
    assert 4 |> map(fn _ -> nil end) |> with_default(33) == 33
  end

  test "sets to the default value the chain returns a val" do
    assert 4 |> map(fn _ -> 44 end) |> with_default(33) == 44
  end
end
