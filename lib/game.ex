defmodule Game do
  # import Player.mar
  # use Board
  defstruct player_1: "X", player_2: "O", current_player: %Player{mark: "X"}, winner: nil, board: %Board{}
  
end
# IO.inspect %Game{}