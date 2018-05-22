defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "test struct" do 
    assert %Game{} = %Game{player_1: "X", player_2: "O", current_player: %Player{mark: "X"}, winner: nil, board: %Board{}}
  end
end