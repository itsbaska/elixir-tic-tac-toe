defmodule Game do
  defstruct player_1: %Player{}, player_2: %Computer{}, current_player: %Player{mark: "X"}, winner: nil, board: %Board{}.spaces
  
  def check_three([x, x, x]), do: true
  def check_three([a, b, c]), do: false
  
  def check_line([head | tail]), do: [check_three(head) | check_line(tail)]
  def check_line([]), do: []

  def convert_to_columns([a, b, c, d, e, f, g, h, i]), do: [[a, d, g], [b, e, h], [c, f, i]]
  def convert_to_diagonals([a, _b, c, _d, e, _f, g, _h, i]), do: [[a, e, i], [g, e, c]]
  def convert_to_rows(board), do: Enum.chunk(board, 3)

  def game_over?(board) do
    cond do
      Enum.any?(convert_to_rows(board) |> check_line, fn(x) -> x end) ->
        true
      Enum.any?(convert_to_columns(board) |> check_line, fn(x) -> x end) ->
        true
      Enum.any?(convert_to_diagonals(board) |> check_line, fn(x) -> x end) ->
        true
      Board.available_spaces(board) |> length == 0 ->
        true
      true ->
        false
    end
  end

end