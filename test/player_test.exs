defmodule PlayerTest do
  use ExUnit.Case

  doctest Player

  test "player struct" do
    assert %Player{} === %Player{mark: "X"}

  end
  
  test "returns the Player mark" do
    assert Player.mark == "X"
  end
  
  test "make move" do
    assert Player.move(["X", 1, "X", "X", "O", 5, 6, "X", 8], 6) == ["X", 1, "X", "X", "O", 5, "X", "X", 8]
  end

end