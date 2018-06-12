defmodule TictacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create a new game" do
    assert TicTacToe.new_game == %Game{}
  end

end