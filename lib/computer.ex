defmodule Computer do
  defstruct mark: "O"
  
  def move(board, _space) do
    space = Enum.random (0..8)
    if Board.is_available?(board, space) do
      Board.make_mark(board, space, %Computer{}.mark)
    else
      move(board, space)
    end
  end
end