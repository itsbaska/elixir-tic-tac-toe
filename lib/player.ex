defmodule Player do
  defstruct mark: "X"

  def move(board, space) do
    Board.make_mark(board, space, %Player{}.mark)
  end
end
