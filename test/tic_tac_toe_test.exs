defmodule TictacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe ".restart_game" do
    test "when the user enters 'no'" do
      defmodule PicksOptionNo do
        def print(_message), do: %Message{}.good_bye
      end
      assert TicTacToe.restart_game("no", PicksOptionNo) == %Message{}.good_bye
    end

    test "when the user enters 'n'" do
      defmodule PicksOptionN do
        def print(_message), do: %Message{}.good_bye
      end
      assert TicTacToe.restart_game("n", PicksOptionN) == %Message{}.good_bye
    end

    test "when the user enters 'yes'" do
      defmodule PicksOptionYes do
        def print(_message), do: nil
      end

      defmodule FakeLoop_1 do
        def configure_game, do: nil
        def loop(_), do: "restarting game"
      end

      assert TicTacToe.restart_game("yes", PicksOptionYes, FakeLoop_1) == "restarting game"
    end

    test "when the user enters 'y'" do
      defmodule PicksOptionY do
        def print(_message), do: nil
      end

      defmodule FakeLoop_2 do
        def configure_game, do: nil
        def loop(_), do: "restarting game"
      end
      assert TicTacToe.restart_game("y", PicksOptionY, FakeLoop_2) == "restarting game"
    end
  end

  describe ".get_user_move" do
    test "when user move is 4" do
      defmodule PickMove do
        def get_move, do: "4"
        def print(_message), do: nil
      end
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8],
                  player_1: %Player{mark: "X"},
                  player_2: %Player{mark: "O"},
                  current_player: %Player{mark: "X"},
                  size: 3}
      assert TicTacToe.get_user_move(game, PickMove).board() == [0, 1, 2, 3, "X", 5, 6, 7, 8]
    end
  end
end