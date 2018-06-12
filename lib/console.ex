defmodule Console do


  def print_board(board = [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _]) do
    IO.write """
  
    ---------------------------

          #{Enum.at(board, 0)}     #{Enum.at(board,1)}     #{Enum.at(board,2)}     #{Enum.at(board, 3)}
        =====+=====+=====+=====
          #{Enum.at(board, 4)}     #{Enum.at(board, 5)}     #{Enum.at(board, 6)}     #{Enum.at(board, 7)}
        =====+=====+=====+=====
          #{Enum.at(board, 8)}     #{Enum.at(board, 9)}    #{Enum.at(board, 10)}     #{Enum.at(board, 11)}
        =====+=====+=====+=====
          #{Enum.at(board, 12)}    #{Enum.at(board, 13)}   #{Enum.at(board, 14)}     #{Enum.at(board, 15)}

    ---------------------------

    """
  end

  def print_board(board) do
    IO.write """

    --------------

      #{Enum.at(board,  0)}   #{Enum.at(board, 1)}   #{Enum.at(board, 2)}
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
    String.trim(IO.gets %Message{}.play_again)
  end

  def get_move do
    String.trim(IO.gets %Message{}.enter_move)    
  end

  def get_board_size do
    String.trim(IO.gets %Message{}.board_size)
  end
end
