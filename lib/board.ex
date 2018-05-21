defmodule Board do
  # @winning_spaces [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  def create do
    [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def three_in_a_row?(board) do 
    Enum.at(board, 0) == Enum.at(board, 1) && Enum.at(board, 1) == Enum.at(board, 2) ||
    Enum.at(board, 3) == Enum.at(board, 4) && Enum.at(board, 4) == Enum.at(board, 5) ||
    Enum.at(board, 6) == Enum.at(board, 7) && Enum.at(board, 7) == Enum.at(board, 8) ||
    Enum.at(board, 0) == Enum.at(board, 3) && Enum.at(board, 3) == Enum.at(board, 6) ||
    Enum.at(board, 1) == Enum.at(board, 4) && Enum.at(board, 4) == Enum.at(board, 7) ||
    Enum.at(board, 2) == Enum.at(board, 5) && Enum.at(board, 5) == Enum.at(board, 8) ||
    Enum.at(board, 0) == Enum.at(board, 4) && Enum.at(board, 4) == Enum.at(board, 8) ||
    Enum.at(board, 2) == Enum.at(board, 4) && Enum.at(board, 4) == Enum.at(board, 6)
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

end
