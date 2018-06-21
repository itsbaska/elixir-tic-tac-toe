defmodule ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Console

  describe "when there are no markers on the board" do
    test "print 3x3 board" do
      game = %Game{board: [0, 1, 2, 3, 4, 5, 6, 7, 8], size: 3}
      test_output = fn -> 
        Console.print_board(game)
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
        Console.print_board(game)
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
      %{ %Game{} | 
        current_player: %Human{mark: "X"}, 
        board: [0, 1, 2, 3, "X", 5, 6, 7, 8],
        size: 3 }
      test_output = fn -> 
        Player.Human.move(game, 4) |> Console.print_board
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
        %{ %Game{} | 
          current_player: %Human{mark: "X"}, 
          board: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
          size: 4}
      test_output = fn -> 
        Player.Human.move(game, 10) |> Console.print_board
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
end