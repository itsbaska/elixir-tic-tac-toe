defmodule Console do

  def print_board(game) do
    board = game.board
    case game.size do 
      4 ->
        IO.write """
      
        ---------------------------
    
             #{Enum.at(board, 0)}   #{Enum.at(board,1)}   #{Enum.at(board,2)}   #{Enum.at(board, 3)}
            ===+===+===+===
             #{Enum.at(board, 4)}   #{Enum.at(board, 5)}   #{Enum.at(board, 6)}   #{Enum.at(board, 7)}
            ===+===+===+===
             #{Enum.at(board, 8)}   #{Enum.at(board, 9)}   #{Enum.at(board, 10)}   #{Enum.at(board, 11)}
            ===+===+===+===
             #{Enum.at(board, 12)}   #{Enum.at(board, 13)}   #{Enum.at(board, 14)}   #{Enum.at(board, 15)}
    
        ---------------------------
    
        """
      3 ->
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
  end

  def print(message) do
    IO.write message
  end

  def prompt_new_game do
    String.trim(IO.gets %Message{}.prompt_new_game) |> String.downcase()
  end

  def get_move do
    String.trim(IO.gets %Message{}.enter_move)    
  end

  def get_board_size do
    String.trim(IO.gets %Message{}.board_size)
  end

  def get_game_type do
    String.trim(IO.gets %Message{}.game_type)
  end

  def get_human_mark(player) do
    String.trim(IO.gets player <> %Message{}.get_human_mark)
  end

end
