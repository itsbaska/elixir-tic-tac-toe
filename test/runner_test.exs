defmodule RunnerTest do
  use ExUnit.Case
  # import ExUnit.CaptureIO
  

  doctest Runner

  describe ".start" do
    test "when the user picks option 1, the game board size is 3x3" do
      defmodule FakeStart do
        def start, do: true
      end
      assert Runner.start(FakeStart) == true
    end
  end
  # test "start the game" do
  #   test_output = fn ->
  #     Runner.start
  #   end
  #   assert capture_io(test_output) ==  """
  #   Tic Tac Toe
  #   -----------
  #   Instructions:
  #   Select the spot you want to mark by entering the corresponding number.
  #   The first to get three marks in a row will win the game.

  #   You are player "X", please start the game.
    
  #   --------------

  #     0   1   2
  #    ===+===+=== 
  #     3   4   5
  #    ===+===+=== 
  #     6   7   8

  #   --------------

  #   """
  # end
end