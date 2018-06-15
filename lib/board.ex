defmodule Board do
  def create(size) do
    last_board_space = (size * size) - 1
    0..last_board_space |> Enum.to_list
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
