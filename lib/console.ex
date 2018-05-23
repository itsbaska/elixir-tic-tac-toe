defmodule Console do
  def print_board(board) do
    IO.write """

    --------------

      #{Enum.at(board,0)}   #{Enum.at(board, 1)}   #{Enum.at(board, 2)}
     ===+===+=== 
      #{Enum.at(board, 3)}   #{Enum.at(board, 4)}   #{Enum.at(board, 5)}
     ===+===+=== 
      #{Enum.at(board, 6)}   #{Enum.at(board, 7)}   #{Enum.at(board, 8)}

    --------------
    
    """
  end

  def print_welcome_msg do 
    IO.write"""
    Tic Tac Toe
    -----------
    Instructions:
    Select the spot you want to mark by entering the corresponding number.
    The first to get three marks in a row will win the game.

    You are player "X", please start the game.
    """
  end

  def print_invalid_msg do
    IO.write"""
    Please enter a number between 0-8.
    """
  end

  def print_spot_taken_msg do
    IO.write"""
    Spot is taken.
    Please try again at a different spot.
    """
  end

  def get_user_spot do
    IO.gets("Please enter spot number")
    # IO.inspect response
  end

end
