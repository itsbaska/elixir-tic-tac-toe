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


  
end