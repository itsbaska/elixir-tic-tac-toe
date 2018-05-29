defmodule Game do
  defstruct player_1: %Player{}, 
            player_2: %Computer{}, 
            current_player: %Player{}, 
            winner: nil, 
            board: %Board{}.spaces
            
  defp check_three([x, x, x]), do: x
  defp check_three([_a, _b, _c]), do: false

  defp check_line([head | tail]), do: [check_three(head) | check_line(tail)]
  defp check_line([]), do: []

  defp convert_to_columns([a, b, c, d, e, f, g, h, i]), do: [[a, d, g], [b, e, h], [c, f, i]]
  defp convert_to_diagonals([a, _b, c, _d, e, _f, g, _h, i]), do: [[a, e, i], [g, e, c]]
  defp convert_to_rows(board), do: Enum.chunk(board, 3)

  def get_winner(board) do
    Enum.find(convert_to_rows(board) |> check_line, fn(x) -> x end) ||
    Enum.find(convert_to_columns(board) |> check_line, fn(x) -> x end) ||
    Enum.find(convert_to_diagonals(board) |> check_line, fn(x) -> x end)
  end

  def is_tie?(board), do: Board.available_spaces(board) |> length == 0

  def game_over?(board) do  
    cond do
      get_winner(board) ->
        true
      is_tie?(board) ->
        true
      true ->
        false
    end
  end

  def change_turn(%Player{}), do: %{ %Game{} | current_player: %Computer{}}
  def change_turn(%Computer{}), do: %{ %Game{} | current_player: %Player{}}

  def mark_spot(game, space) do
    Board.make_mark(game.board, space, game.current_player)
  end
end