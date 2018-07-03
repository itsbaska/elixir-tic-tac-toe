defmodule ConfigurationTest do
  use ExUnit.Case
  alias Player.Human, as: Human
  alias Player.Computer, as: Computer

  doctest Configuration

  describe "configure_game" do
    test "configure_game" do
      defmodule FakeSetup do
        def get_players(_), do:  {%Player.Human{mark: "x"}, %Player.Human{mark: "o"}}
        def get_board_size(_), do: 3
      end

      defmodule PicksHumVShum do
        def get_game_type, do: "1"
      end
      assert Configuration.configure_game(FakeSetup, PicksHumVShum) == %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8], 
                                                      size: 3,
                                                      player_1: %Player.Human{mark: "x"},
                                                      player_2: %Player.Human{mark: "o"},
                                                      current_player: %Player.Human{mark: "x"}}
    end
  end


  describe ".set_players" do
    test "when the user picks option 1, the game type is human_vs_human" do
      defmodule PicksOptionOne_HumVSHum do
        def get_player_marks(_), do: "x"
        def print(_message), do: nil
      end

      defmodule PicksOptionOne_HumVSHum2 do
        def get_player_marks(_), do: "o"
        def print(_message), do: nil

      end
      assert Configuration.set_players(true, "1", PicksOptionOne_HumVSHum, PicksOptionOne_HumVSHum2) == {%Player.Human{mark: "x"}, %Player.Human{mark: "o"}}
    end

    test "when the user picks option 2, the game type is human_vs_computer" do
      defmodule PicksOptionTwo_HumVSCom do
        def get_player_marks(_), do: "x"
        def print(_message), do: nil
      end
      assert Configuration.set_players(true, "2", PicksOptionTwo_HumVSCom, PicksOptionOne_HumVSHum2) == {%Player.Human{mark: "x"}, %Player.Computer{mark: "o"}}
    end

    test "when the user picks invalid option" do
      defmodule PicksInvalidOption do
        def print(_message), do: nil
      end

      defmodule TestCall_3 do
        def test_call(_console), do: :was_called
      end 
      assert Configuration.set_players(false, "4", PicksInvalidOption, PicksOptionOne_HumVSHum2, &TestCall_3.test_call/1) == :was_called
    end
  end

  describe ".set_player_marks" do
    test "when user enters 'W' as mark" do
      defmodule PickMarkW do
        def get_player_marks(_), do: "W"
        def print(_message), do: nil
      end
      assert Configuration.set_player_marks(true, Player, "W", PickMarkW) == "W"
    end

    test "when user enters 'X' as mark" do
      defmodule PickMarkX do
        def get_player_marks(_), do: "X"
        def print(_message), do: nil
      end
      assert Configuration.set_player_marks(true, Player, "X", PickMarkX) == "X"
    end

    test "when there is infinit loop" do
      defmodule PickBlank do
        def get_player_marks(_), do: ""
        def print(_message), do: nil
      end

      defmodule TestCall_1 do
        def test_call(_, _), do: :was_called
      end 
      assert Configuration.set_player_marks(false, "", "xx", PickBlank, &TestCall_1.test_call/2) == :was_called
    end
  end

  describe ".get_player_marks" do
    test "when user enters 'X' as mark" do
      defmodule PickMarkX_2 do
        def get_player_marks(_), do: "X"
        def print(_message), do: nil
      end
      assert Configuration.get_player_marks("", PickMarkX_2) == "X"
    end

    test "when the user enters a blank mark, and there is an infinit loop" do
      defmodule PickBlank_3 do
        def get_player_marks(_), do: ""
        def print(_message), do: nil
      end

      defmodule BlankFakeMark do
        def set_player_marks(_, _, _), do: :was_called
      end 
      assert Configuration.get_player_marks("", PickBlank_3, BlankFakeMark) == :was_called
    end
  end

  describe ".get_marks_for_human_vs_computer_game" do
    test "when user enters 'X' as mark" do
      defmodule ComputerPickO do
        def get_player_marks(_), do: "X"
        def print(_message), do: nil
      end
      assert Configuration.get_marks(2, ComputerPickO) == {%Human{mark: "X"}, %Computer{mark: "O"}}
    end

    test "when user enters 'x' as mark" do
      defmodule ComputerPickO_2 do
        def get_player_marks(_), do: "x"
        def print(_message), do: nil
      end
      assert Configuration.get_marks(2, ComputerPickO_2) == {%Human{mark: "x"}, %Computer{mark: "o"}}
    end
  end

  describe ".get_marks_for_human_vs_human_game" do
    test "when user enters the same marks" do
      defmodule HumanPick do
        def get_player_marks(_), do: "X"
        def print(_message), do: nil
      end
      
      defmodule Human2_Pick do
        def get_player_marks(_), do: "W"
        def print(_message), do: nil
      end

      assert Configuration.get_marks(1, HumanPick, Human2_Pick) == {%Human{mark: "X"}, %Human{mark: "W"}}
    end
  end

  describe ".get_random_letter" do
    test "random letter with upcase" do
      assert String.match?(Configuration.get_random_letter, ~r/[A-Z]/)
    end
  end

  describe ".get_board_size" do
    test "when the user picks option 1, the game board size is 3x3" do
      defmodule PicksOptionOne do
        def print(_message), do: nil
      end
      assert Configuration.set_board_size(true, "1", PicksOptionOne) == 3
    end

    test "when the user picks option 2, the game board size is 4x4" do
      defmodule PicksOptionTwo do
        def print(_message), do: nil
      end
      assert Configuration.set_board_size(true, "2", PicksOptionTwo) == 4
    end

    test "when the user picks invalid option" do
      defmodule PicksInvalidGameTypeOption do
        def print(_message), do: nil
      end

      defmodule TestCall_2 do
        def test_call(_), do: :was_called
      end 
      assert Configuration.set_board_size(false, "3", PicksInvalidGameTypeOption, &TestCall_2.test_call/1) == :was_called
    end
  end
end