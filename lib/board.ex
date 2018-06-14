defmodule Board do
  defstruct spaces: [0, 1, 2, 3, 4, 5, 6, 7, 8]
  def create("3x3") do
    [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def create("4x4") do
    [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
  end

  def is_available?(board, space) do
    Enum.at(board, space) != "X" and Enum.at(board, space) != "O"
  end

  def make_mark(board, space, player) do
    List.replace_at(board, space, player)
  end

  def available_spaces(board) do
    Enum.filter(board, fn(space) -> space != "X" and space != "O" end)
  end

  def available_spaces_number(board) do
    board
    |> available_spaces
    |> length
  end

  def reset_space(board, space) do
    List.replace_at(board, space, space)
  end
end
