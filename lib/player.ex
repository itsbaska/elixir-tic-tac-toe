defmodule Player do
  # defstruct mark: "X"

  def mark do
    "X"
  end

  def move(board, space, mark) do
    Board.make_mark(board, space, mark)
  end

end
