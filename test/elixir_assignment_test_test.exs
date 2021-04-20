defmodule ElixirAssignmentTestTest do
  use ExUnit.Case
  doctest ElixirAssignmentTest

  test "greets the world" do
    assert ElixirAssignmentTest.hello() == :world
  end
end
