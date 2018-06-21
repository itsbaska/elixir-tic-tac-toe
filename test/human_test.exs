defmodule HumanTest do
  use ExUnit.Case
  alias Player.Human, as: Human

  doctest Player.Human

  test "player struct" do
    assert %Human{} === %Human{mark: nil}

  end
  
  test "make move" do
    defmodule PickMove do
      def get_move, do: "6"
      def print(_message), do: nil
    end
    game_1 = 
      %Game{current_player: %Human{mark: "X"}, 
            board: ["X", 1, "X", "X", "O", 5, 6, "X", 8],
            player_1: %Human{mark: "X"},
            player_2: %Human{mark: "O"},
            size: 3}
    game_2 = 
      %Game{current_player: %Human{mark: "O"},
            board: ["X", 1, "X", "X", "O", 5, "X", "X", 8],
            player_1: %Human{mark: "X"},
            player_2: %Human{mark: "O"},
            size: 3}
    assert Human.move(game_1, PickMove) == game_2
  end


  describe ".get_user_move" do
    test "when user move is 4" do
      defmodule PickMove3 do
        def get_move, do: "4"
        def print(_message), do: nil
      end
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"},
                  current_player: %Human{mark: "X"},
                  size: 3}
      assert Human.get_user_move(game, PickMove3) == 4
    end
  end
end