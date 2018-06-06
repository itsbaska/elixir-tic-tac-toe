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

  def print(message) do
    IO.write message
  end

  def play_again do
    play_again = IO.gets "Would you ike to play again? Yes or No?\n" 
    String.trim(play_again)
  end
end
