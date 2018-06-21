defmodule PlayerTest do
  use ExUnit.Case

  doctest Player

  test "player struct" do
    assert %Player{} === %Player{mark: nil}

  end
  
  
  test "make move" do
    game_1 = 
      %Game{current_player: %Player{mark: "X"}, 
            board: ["X", 1, "X", "X", "O", 5, 6, "X", 8],
            player_1: %Player{mark: "X"},
            player_2: %Player{mark: "O"}}
    game_2 = 
      %Game{current_player: %Player{mark: "O"},
            board: ["X", 1, "X", "X", "O", 5, "X", "X", 8],
            player_1: %Player{mark: "X"},
            player_2: %Player{mark: "O"}}
    assert Player.move(game_1, 6) == game_2
  end

end