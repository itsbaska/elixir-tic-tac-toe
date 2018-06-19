defmodule TictacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe ".get_board_size" do
    test "when the user picks option 1, the game board size is 3x3" do
      defmodule PicksOptionOne do
        def get_board_size, do: "1"
        def print(_message), do: nil
      end
      assert TicTacToe.get_board_size(PicksOptionOne) == 3
    end

    test "when the user picks option 2, the game board size is 4x4" do
      defmodule PicksOptionTwo do
        def get_board_size, do: "2"
        def print(_message), do: nil
      end
      assert TicTacToe.get_board_size(PicksOptionTwo) == 4
    end
  end

  describe ".restart_game" do
    test "when the input is 'no'" do
      defmodule PicksOptionNo do
        def print(_message), do: %Message{}.good_bye
      end
      assert TicTacToe.restart_game("no", PicksOptionNo) == %Message{}.good_bye
    end

    test "when the input is 'n'" do
      defmodule PicksOptionN do
        def print(_message), do: %Message{}.good_bye
      end
      assert TicTacToe.restart_game("n", PicksOptionN) == %Message{}.good_bye
    end

    test "when the input is 'yes'" do
      defmodule PicksOptionYes do
        def print(_message), do: nil
      end

      defmodule FakeLoop_1 do
        def configure_game, do: nil
        def loop(_), do: "restarting game"
      end

      assert TicTacToe.restart_game("yes", PicksOptionYes, FakeLoop_1) == "restarting game"
    end

    test "when the input is 'y'" do
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

  describe ".get_player_marks" do
    test "when user enters 'W' as mark" do
      defmodule PickMarkW do
        def get_player_marks, do: "W"
        def print(_message), do: nil
      end
      assert TicTacToe.get_player_marks(PickMarkW) == "W"
    end

    test "when user enters 'X' as mark" do
      defmodule PickMarkX do
        def get_player_marks, do: "X"
        def print(_message), do: nil
      end
      assert TicTacToe.get_player_marks(PickMarkX) == "X"
    end
  end

  describe ".get_marks_for_human_vs_computer_game" do
    test "when user enters 'X' as mark" do
      defmodule ComputerPickO do
        def get_player_marks, do: "X"
        def print(_message), do: nil
      end
      assert TicTacToe.get_marks_for_human_vs_computer_game(ComputerPickO) == {%Player{mark: "X"}, %Computer{mark: "O"}}
    end
    test "when user enters 'x' as mark" do
      defmodule ComputerPickO_2 do
        def get_player_marks, do: "x"
        def print(_message), do: nil
      end
      assert TicTacToe.get_marks_for_human_vs_computer_game(ComputerPickO_2) == {%Player{mark: "x"}, %Computer{mark: "O"}}
    end
  end

  describe ".get_marks_for_human_vs_human_game" do
    test "when user enters 'X' as mark" do
      defmodule HumanPick do
        def get_player_marks, do: "X"
        def print(_message), do: nil
      end
      defmodule Human2_Pick do
        def get_player_marks, do: "W"
        def print(_message), do: nil
      end

      assert TicTacToe.get_marks_for_human_vs_human_game(HumanPick, Human2_Pick) == {%Player{mark: "X"}, %Player{mark: "W"}}
    end
    test "when user enters 'x' as mark" do
      defmodule HumanPick_2 do
        def get_player_marks, do: "x"
        def print(_message), do: nil
      end
      defmodule Human2_Pick_2 do
        def get_player_marks, do: "S"
        def print(_message), do: nil
      end
      assert TicTacToe.get_marks_for_human_vs_human_game(HumanPick_2, Human2_Pick_2) == {%Player{mark: "x"}, %Player{mark: "S"}}
    end
  end
end