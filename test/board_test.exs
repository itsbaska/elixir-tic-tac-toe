defmodule BoardTest do
  use ExUnit.Case

  doctest Board

  test "player struct" do
    assert %Board{} === %Board{spaces: [0, 1, 2, 3, 4, 5, 6, 7, 8]}
  end

  test "returns the board" do
    assert Board.create == [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  test "returns true if 'O' three in a row" do
    assert Board.three_in_a_row?(["X", 1, "O", "X", "O", 5, "O", "X", 8]) == true
  end
  
  test "returns false if no three in a row" do
    assert Board.three_in_a_row?(["X", 1, "X", "X", "O", 5, "O", "X", 8]) == false
  end

  test "returns true if board space is available" do
    assert Board.is_available?(["X", 1, "X", "X", "O", 5, "O", "X", 8], 5) == true
  end

  test "returns false if board space is not available" do
    assert Board.is_available?(["X", 1, "X", "X", "O", 5, "O", "X", 8], 6) == false
  end

  test "mark board with player marker" do
    assert Board.make_mark(["X", 1, "X", "X", "O", 5, 6, "X", 8], 6, "O") == ["X", 1, "X", "X", "O", 5, "O", "X", 8]
  end

  test "returns all available spaces" do
    assert Board.available_spaces(["X", 1, "X", "X", "O", 5, 6, "X", 8]) == [1, 5, 6, 8]
  end

  test "reset space" do
    assert Board.reset_space(["X", 1, "X", "X", "O", 5, 6, "X", 8], 7) == ["X", 1, "X", "X", "O", 5, 6, 7, 8]
  end
end