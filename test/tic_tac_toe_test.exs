defmodule TictacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create a new game" do
    board = [1, 2, 3, 4, 5, 6, 7, 8]
    assert TicTacToe.new_game(board).board == board
  end

end