defmodule PlayerTest do
  use ExUnit.Case

  doctest Player

  test "returns the player" do
    assert Player.mark == "X"
  end


  test "make move" do
    assert Player.move(["X", 1, "X", "X", "O", 5, 6, "X", 8], 6, "O") == ["X", 1, "X", "X", "O", 5, "O", "X", 8]
  end
end