defmodule MessageTest do
  use ExUnit.Case

  doctest Message

  test "return welcome message" do
    assert %Message{}.welcome === """
                                  Tic Tac Toe
                                  -----------
                                  Instructions:
                                  Select the spot you want to mark by entering the corresponding number.
                                  The first to get three marks in a row will win the game.

                                  You are player "X", please start the game.
                                  """
  end

  test "return invalid input message" do
    assert %Message{}.invalid === """
                                  Please enter a number between 0-8.
                                  """
  end

  test "return spot taken message" do
    assert %Message{}.spot_taken === """
                                  Spot is taken.
                                  Please try again at a different spot.
                                  """
  end

  test "return Computer win message" do
    assert %Message{}.win === """
                                  Computer Wins!!!
                                  """
  end

  test "return game tie message" do
    assert %Message{}.tie === """
                                  It's a Tie!!!
                                  """
  end
end