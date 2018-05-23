defmodule ConsoleTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Console

  describe "when there are no markers on the board" do
    test "#print_board" do
      board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
      test_output = fn -> 
        Console.print_board(board)
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
  end

  describe "when there is a marker on the board" do
    test "#print_board" do
      board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
      test_output = fn -> 
        Player.move(board, 4) |> Console.print_board
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
    
  end

  describe "when the game starts running" do
    test "#print_welcome_msg" do
      test_output = fn -> 
        Console.print_welcome_msg
      end
      assert capture_io(test_output) == """
      Tic Tac Toe
      -----------
      Instructions:
      Select the spot you want to mark by entering the corresponding number.
      The first to get three marks in a row will win the game.

      You are player "X", please start the game.
      """
    end
  end

  describe "when the user enters an invalid entry" do
    test "#print_invalid_msg" do
      test_output = fn -> 
        Console.print_invalid_msg
      end
      assert capture_io(test_output) == """
      Please enter a number between 0-8.
      """
    end

    test "#print_spot_taken_msg" do
      test_output = fn -> 
        Console.print_spot_taken_msg
      end
      assert capture_io(test_output) == """
      Spot is taken.
      Please try again at a different spot.
      """
    end
  end

  describe "receive user input" do
    test "get_user_spot" do
      # input = Console.get_user_spot
      # assert capture_io([input: "1"], fn -> 
      #   Console.get_user_spot
      # end) == "1"
    end
  end
end