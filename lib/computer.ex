defmodule Computer do
  defstruct mark: "O"
  
  def move(board, space) do
    Board.make_mark(board, space, %Computer{}.mark)
  end
  
  
end