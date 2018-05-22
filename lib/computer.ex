defmodule Computer do
  defstruct mark: "O"
  
  def mark do
    "O"
  end

  def move(board, space) do
    Board.make_mark(board, space, Computer.mark)
  end

  
end