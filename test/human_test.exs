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
     assert Player.Move.move(game_1.current_player, game_1, PickMove) == 6
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

    test "when user move is invalid" do
      defmodule PickMove7 do
        def get_move, do: "9"
        def print(_message), do: nil
      end
      defmodule InvalidPick3 do
        def set_user_move(_, _, _, _, _), do: :was_called
      end
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"},
                  current_player: %Human{mark: "X"},
                  size: 3}
      assert Human.get_user_move(game, PickMove7, InvalidPick3) == :was_called
    end
  end

  describe ".set_user_move" do
    test "when user move is 4" do
      defmodule PickMove4 do
        def print(_message), do: nil
      end
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"},
                  current_player: %Human{mark: "X"},
                  size: 3}
      assert Human.set_user_move(true, "4", game, PickMove4) == 4
    end

    test "when user move is 9" do
      defmodule PickMove5 do
        def print(_message), do: nil
      end

      defmodule InvalidPick do
        def test_call(_, _), do: :was_called
      end
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"},
                  current_player: %Human{mark: "X"},
                  size: 3}
      assert Human.set_user_move(false, "4", game, &InvalidPick.test_call/2, PickMove5) == :was_called
    end

    test "when user move is 4 and spot is taken" do
      defmodule PickMove6 do
        def print(_message), do: nil
      end

      defmodule InvalidPick2 do
        def test_call(_, _), do: :was_called
      end
      game = %Game{board: [0, 1, 2, 3, "X", 5, 6, 7, 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"},
                  current_player: %Human{mark: "X"},
                  size: 3}
      assert Human.set_user_move(true, "4", game, &InvalidPick2.test_call/2, PickMove6) == :was_called
    end
  end
end