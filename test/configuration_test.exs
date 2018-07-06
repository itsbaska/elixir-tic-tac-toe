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

  describe ".get_human_mark" do
    test "when user enters 'X' as mark" do
      defmodule PickMarkX_2 do
        def get_human_mark(_), do: "X"
        def print(_message), do: nil
      end
      assert Configuration.get_human_mark("", PickMarkX_2) == "X"
    end

    test "when the user enters a blank mark, and there is an infinit loop" do
      defmodule PickBlank_3 do
        def get_human_mark(_), do: ""
        def print(_message), do: nil
      end

      defmodule BlankFakeMark do
        def get_human_mark(_), do: "x" 
      end 
      assert Configuration.get_human_mark("", PickBlank_3, &BlankFakeMark.get_human_mark/1) == "x"
    end
  end

  describe ".get_computer_mark" do
    test "when user enters 'X' as mark" do
      assert Configuration.get_computer_mark("X") == "O"
    end

    test "when user enters 'x' as mark" do
      assert Configuration.get_computer_mark("x") == "o"
    end

    test "when user enters 'O' as mark" do
      assert Configuration.get_computer_mark("O") == "X"
    end

    test "when user enters 'o' as mark" do
      assert Configuration.get_computer_mark("o") == "x"
    end

    test "when user enters letter that is not x or o as mark" do
      defmodule ComputerPickRandomF do
        def get_random_letter, do: "F"
      end
      assert Configuration.get_computer_mark("w", ComputerPickRandomF) == "F"
    end

    test "when user enters letter that is not x or o as mark and computer picks the same" do
      defmodule ComputerPickRandomK do
        def get_random_letter, do: "F"
      end
      defmodule ComputerPickRandomM do
        def get_random_letter, do: "M"
      end
      assert Configuration.get_computer_mark("F", ComputerPickRandomK, ComputerPickRandomM) == "M"
    end
  end

  describe ".get_human_vs_computer_marks" do
    test "when user enters 'X' as mark" do
      defmodule HumanPickX do
        def get_human_mark(_), do: "X"
        def print(_message), do: nil
      end
      assert Configuration.get_human_vs_computer_marks(HumanPickX) == {%Human{mark: "X"}, %Computer{mark: "O"}}
    end

    test "when user enters 'x' as mark" do
      defmodule HumanPickx do
        def get_human_mark(_), do: "x"
        def print(_message), do: nil
      end
      assert Configuration.get_human_vs_computer_marks(HumanPickx) == {%Human{mark: "x"}, %Computer{mark: "o"}}
    end

    test "when user enters 'O' as mark" do
      defmodule HumanPickO do
        def get_human_mark(_), do: "O"
        def print(_message), do: nil
      end
      assert Configuration.get_human_vs_computer_marks(HumanPickO) == {%Human{mark: "O"}, %Computer{mark: "X"}}
    end

    test "when user enters 'o' as mark" do
      defmodule HumanPicko do
        def get_human_mark(_), do: "o"
        def print(_message), do: nil
      end
      assert Configuration.get_human_vs_computer_marks(HumanPicko) == {%Human{mark: "o"}, %Computer{mark: "x"}}
    end
    
    test "when user enters mark other than o or x " do
      defmodule HumanPickNotONotx do
        def get_human_mark(_), do: "w"
        def print(_message), do: nil
      end

      defmodule ComputerPickRandom do
        def get_computer_mark(_), do: "F"
      end
      assert Configuration.get_human_vs_computer_marks(HumanPickNotONotx, ComputerPickRandom) == {%Human{mark: "w"}, %Computer{mark: "F"}}
    end
  end

  describe ".get_human_vs_human_marks" do
    test "when user enters different marks" do
      defmodule HumanPickDiffMark do
        def get_human_mark(_), do: "X"
        def print(_message), do: nil
      end
      
      defmodule HumanPickDiffMark2 do
        def get_human_mark(_), do: "W"
        def print(_message), do: nil
      end

      assert Configuration.get_human_vs_human_marks(HumanPickDiffMark, HumanPickDiffMark2) == {%Human{mark: "X"}, %Human{mark: "W"}}
    end
  
    test "when user enters same marks" do
      defmodule HumanPickSameMark do
        def get_human_mark(_), do: "X"
        def print(_message), do: nil
      end
      
      defmodule HumanPickSameMark2 do
        def get_human_mark(_), do: "X"
        def print(_message), do: nil
      end

      defmodule HumanPickSameMarkInvalid do
        def test_call, do: :was_called
      end

      assert Configuration.get_human_vs_human_marks(HumanPickSameMark, HumanPickSameMark2, &HumanPickSameMarkInvalid.test_call/0) == :was_called
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
        def get_board_size, do: "1"
        def print(_message), do: nil
      end
      assert Configuration.get_board_size( PicksOptionOne) == 3
    end

    test "when the user picks option 2, the game board size is 4x4" do
      defmodule PicksOptionTwo do
        def get_board_size, do: "2"
        def print(_message), do: nil
      end
      assert Configuration.get_board_size( PicksOptionTwo) == 4
    end

    test "when the user picks invalid option" do
      defmodule PicksInvalidGameTypeOption do
        def get_board_size, do: "3"
        def print(_message), do: nil
      end

      defmodule TestCall_2 do
        def test_call(_), do: :was_called
      end 
      assert Configuration.get_board_size( PicksInvalidGameTypeOption, &TestCall_2.test_call/1) == :was_called
    end
  end
end