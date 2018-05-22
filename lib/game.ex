defmodule Game do
  defstruct player_1: "X", player_2: "O", current_player: %Player{mark: "X"}, winner: nil, board: %Board{}
  
end
# IO.inspect %Game{}