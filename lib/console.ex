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

  # def print_board(board) do
  # end

  def print(message) do
    IO.write message
  end

  def play_again do
    String.trim(IO.gets %Message{}.play_again) |> String.downcase()
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

  def get_player_marks do
    String.trim(IO.gets %Message{}.get_player_marks)
  end
end
