defmodule ResultTest do
  use ExUnit.Case
  import Result

  test "map returns the error when the input is an error" do
    assert {:error, "My Error"} |> map(fn _ -> 2 end) == {:error, "My Error"}
  end

  test "map returns the value processed by the given function when the input value a success" do
    assert {:ok, 2} |> map(fn a -> a + 1 end) == {:ok, 3}
  end

  test "and_then should return the first result if first one error" do
    assert {:error, "My error"} |> and_then(fn _ -> {:ok, 2} end) == {:error, "My error"}
  end

  test "and_then should return ok if first result is ok and the return value returned by the lamda is :ok" do
    assert {:ok, 1} |> and_then(fn _ -> {:ok, 2} end) == {:ok, 2}
  end

  test "map the error when there is an error as input" do
    assert {:error, "This is an error"} |> map_error("New error") == {:error, "New error"}
  end

  test "map the error with a function when there is an error as input" do
    assert {:error, "This is an error"} |> map_error(fn a -> a <> "2" end) ==
             {:error, "This is an error2"}
  end

  test "return the input when success on map_error" do
    assert {:ok, 12} |> map_error("New error") == {:ok, 12}
  end

  test "converts to an error result when nil value" do
    assert nil |> from_maybe("My Error") == {:error, "My Error"}
  end

  test "converts to an success result when non nil value" do
    assert 12 |> from_maybe("My Error") == {:ok, 12}
  end
end
