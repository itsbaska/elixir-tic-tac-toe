defmodule HumanTest do
  use ExUnit.Case

  doctest Human

  test "player struct" do
    assert %Human{} === %Human{mark: nil}

  end
  
  test "make move" do
    game_1 = 
      %Game{current_player: %Human{mark: "X"}, 
            board: ["X", 1, "X", "X", "O", 5, 6, "X", 8],
            player_1: %Human{mark: "X"},
            player_2: %Human{mark: "O"}}
    game_2 = 
      %Game{current_player: %Human{mark: "O"},
            board: ["X", 1, "X", "X", "O", 5, "X", "X", 8],
            player_1: %Human{mark: "X"},
            player_2: %Human{mark: "O"}}
    assert Player.Human.move(game_1, 6) == game_2
  end
end