defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer


  test "player struct" do
    assert %Computer{} === %Computer{mark: "O"}

  end

  test "returns the Computer mark" do
    assert Computer.mark == "O"
  end

  test "make move" do
    assert Computer.move(["X", "O", "X", "X", "O", "O", "O", "X", 8], 8) == ["X", "O", "X", "X", "O", "O", "O", "X", "O"]
  end

  test "get_best_move" do
    
  end

end