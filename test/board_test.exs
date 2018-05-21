defmodule BoardTest do
  use ExUnit.Case

  doctest Board

  test "returns the board" do
    assert Board.get_board == [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "returns true if winning space" do 
    assert Board.is_winning_space?([0, 1, 2]) == true
  end

  test "returns false if not a winning space" do 
    assert Board.is_winning_space?([0, 1, 3]) == false
  end
end