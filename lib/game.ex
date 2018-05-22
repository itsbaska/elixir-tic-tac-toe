defmodule Game do
  defstruct player_1: %Player{}, player_2: %Computer{}, current_player: %Player{mark: "X"}, winner: nil, board: %Board{}
  
end