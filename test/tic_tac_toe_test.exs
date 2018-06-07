defmodule TictacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create a new game" do
    assert TicTacToe.new == %Game{}
  end

end