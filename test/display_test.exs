defmodule DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest Display

  describe "when there are no markers on the board" do
    test "#print_board" do
      board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
      test_output = fn -> 
        Display.print_board(board)
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
      board = [0, 1, 2, 3, "X", 5, 6, 7, 8]
      test_output = fn -> 
        Display.print_board(board)
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
    test "#print_welcom_msg" do
      test_output = fn -> 
        Display.print_welcome_msg
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


  
end