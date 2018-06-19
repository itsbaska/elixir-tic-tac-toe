defmodule ConfigurationTest do
  use ExUnit.Case
  doctest Configuration

  describe ".get_board_size" do
    test "when the user picks option 1, the game board size is 3x3" do
      defmodule PicksOptionOne do
        def get_board_size, do: "1"
        def print(_message), do: nil
      end
      assert Configuration.get_board_size(PicksOptionOne) == 3
    end

    test "when the user picks option 2, the game board size is 4x4" do
      defmodule PicksOptionTwo do
        def get_board_size, do: "2"
        def print(_message), do: nil
      end
      assert Configuration.get_board_size(PicksOptionTwo) == 4
    end
  end

  describe ".get_player_marks" do
    test "when user enters 'W' as mark" do
      defmodule PickMarkW do
        def get_player_marks, do: "W"
        def print(_message), do: nil
      end
      assert Configuration.get_player_marks(PickMarkW) == "W"
    end

    test "when user enters 'X' as mark" do
      defmodule PickMarkX do
        def get_player_marks, do: "X"
        def print(_message), do: nil
      end
      assert Configuration.get_player_marks(PickMarkX) == "X"
    end
  end

  describe ".get_marks_for_human_vs_computer_game" do
    test "when user enters 'X' as mark" do
      defmodule ComputerPickO do
        def get_player_marks, do: "X"
        def print(_message), do: nil
      end
      assert Configuration.get_marks(2, ComputerPickO) == {%Player{mark: "X"}, %Computer{mark: "O"}}
    end
    test "when user enters 'x' as mark" do
      defmodule ComputerPickO_2 do
        def get_player_marks, do: "x"
        def print(_message), do: nil
      end
      assert Configuration.get_marks(2, ComputerPickO_2) == {%Player{mark: "x"}, %Computer{mark: "o"}}
    end
  end

  describe ".get_marks_for_human_vs_human_game" do
    test "when user enters the same marks" do
      defmodule HumanPick do
        def get_player_marks, do: "X"
        def print(_message), do: nil
      end
      defmodule Human2_Pick do
        def get_player_marks, do: "W"
        def print(_message), do: nil
      end

      assert Configuration.get_marks(1, HumanPick, Human2_Pick) == {%Player{mark: "X"}, %Player{mark: "W"}}
    end
  end
end