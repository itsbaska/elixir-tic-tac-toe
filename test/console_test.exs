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

  test "#get_human_mark" do
    test_output = fn -> Console.print(%Message{}.get_human_mark)end
    assert capture_io(test_output) == """
                                      Please select a single letter, number, or symbol to be your mark.
                                      """
  end

  test "#prompt_new_game" do
    test_output = fn -> Console.prompt_new_game() |> IO.write end
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

  test "#get_human_mark 2" do
    test_output = fn -> Console.get_human_mark("Player 1 ~") |> IO.write end
    assert capture_io("x", test_output) == "Player 1 ~Please select a single letter, number, or symbol to be your mark.\nx"
  end
end