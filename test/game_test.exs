defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "test struct" do 
    assert %Game{} === %Game{player_1: %Player{mark: "X"}, player_2: %Computer{mark: "O"}, current_player: %Player{mark: "X"}, winner: nil, board: %Board{}}
  end
end