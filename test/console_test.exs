defmodule ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  alias Player.Human, as: Human

  doctest Console

  describe "when there are no markers on the board" do
    test "print 3x3 board" do
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8], size: 3}
      test_output = fn -> 
        game |> Console.print_board
      end
      assert capture_io(test_output) == """
     
      --------------
  
        0   1   2
       ===+===+=== 
        3   4   5
       ===+===+=== 
        6   7   8
  
      --------------
  
      """
    end

    test "print 4x4 board" do
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], size: 4}
      test_output = fn -> 
        game |> Console.print_board
      end
      assert capture_io(test_output) == """
     
      ---------------------------

           0   1   2   3
          ===+===+===+===
           4   5   6   7
          ===+===+===+===
           8   9   10   11
          ===+===+===+===
           12   13   14   15

      ---------------------------
      
      """
    end


  end

  describe "when there is a marker on the board" do
    test "print 3x3 board" do
      game = 
      %Game{ current_player: %Human{mark: "X"}, 
              board: [0, 1, 2, 3, "X", 5, 6, 7, 8],
              size: 3 }
      test_output = fn -> 
        game |> Console.print_board
      end
      assert capture_io(test_output) == """

      --------------
  
        0   1   2
       ===+===+=== 
        3   X   5
       ===+===+=== 
        6   7   8
  
      --------------
      
      """
    end
    
    test "print 4x4 board" do
      game = 
      %Game{current_player: %Human{mark: "X"}, 
            board: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "X", 11, 12, 13, 14, 15],
            size: 4}
      test_output = fn -> 
        game |> Console.print_board
      end
      assert capture_io(test_output) == """
     
      ---------------------------

           0   1   2   3
          ===+===+===+===
           4   5   6   7
          ===+===+===+===
           8   9   X   11
          ===+===+===+===
           12   13   14   15

      ---------------------------
      
      """
    end
  end

  describe "when app starts" do
    test "print welcome message" do 
      test_output = fn -> Console.print(%Message{}.welcome) end
      assert capture_io(test_output) == """
                                        Tic Tac Toe
                                        -----------
                                        """
    end
  end

  describe "when the user enters an invalid entry" do
    test "print invalid message" do
      test_output = fn -> Console.print(%Message{}.invalid) end
      assert capture_io(test_output) == """
                                        I didn't quite get that...
                                        Please try again.

                                        """
    end

    test "#print_spot_taken_msg" do
      test_output = fn -> Console.print(%Message{}.spot_taken)end
      assert capture_io(test_output) == """
                                        Spot is taken.
                                        Please try again at a different spot.
                                        """
    end
  end

  test "#get_player_mark" do
    test_output = fn -> Console.print(%Message{}.get_player_marks)end
    assert capture_io(test_output) == """
                                      Please select a single letter, number, or symbol to be your mark.
                                      """
  end

  test "#play_again" do
    test_output = fn -> Console.play_again() |> IO.write end
    assert capture_io("yes", test_output) == "Would you like to play again? Yes or No?\n\nyes"
  end

  test "#get_move" do
    test_output = fn -> Console.get_move() |> IO.write end
    assert capture_io("yes", test_output) == "Please enter your move >\nyes"
  end

  test "#get_board_size" do
    test_output = fn -> Console.get_board_size() |> IO.write end
    assert capture_io("1", test_output) == "Select the game board size:\n1) 3x3\n2) 4x4\n1"
  end

  test "#get_game_type" do
    test_output = fn -> Console.get_game_type() |> IO.write end
    assert capture_io("1", test_output) == "Select game type:\n1) Human VS Human\n2) Human VS Computer\n1"
  end

  test "#get_player_marks" do
    test_output = fn -> Console.get_player_marks("Player 1 ~") |> IO.write end
    assert capture_io("x", test_output) == "Player 1 ~Please select a single letter, number, or symbol to be your mark.\nx"
  end
  
  describe ".win_message" do
    test "when game is a tie" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "x", "o", "x"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Human{mark: "o"},
                    current_player: %Player.Human{mark: "x"}}
      assert Console.win_message(game) == "It's a Tie!!!\n"
    end

    test "when x is winner" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Human{mark: "o"},
                    current_player: %Player.Human{mark: "x"}}
      assert Console.win_message(game) == "o, is winner!!!\n\n"
    end
  end

  describe ".turn_message" do
    test "when Computer is current player" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Computer{mark: "o"},
                    current_player: %Player.Computer{mark: "x"}}

      test_output = fn -> 
        game |> Console.turn_message
      end
      assert capture_io(test_output) == """
                                        Computers turn...
                                        """
     
    end

    test "when Human Player 1 is current player" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Human{mark: "o"},
                    current_player: %Player.Human{mark: "x"}}

      test_output = fn -> 
        game |> Console.turn_message
      end
      assert capture_io(test_output) == """
                                        Player 1 turn...
                                        """
     
    end

    test "when Human Player 2 is current player" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Human{mark: "o"},
                    current_player: %Player.Human{mark: "o"}}

      test_output = fn -> 
        game |> Console.turn_message
      end
      assert capture_io(test_output) == """
                                        Player 2 turn...
                                        """
     
    end
  end
end