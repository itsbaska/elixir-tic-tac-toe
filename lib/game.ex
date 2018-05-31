defmodule Game do
  defstruct player_1: %Player{}, 
            player_2: %Computer{}, 
            current_player: %Player{}, 
            winner: nil, 
            board: %Board{}.spaces,
            over: false
            
  defp check_three([x, x, x]), do: x
  defp check_three([_a, _b, _c]), do: nil

  defp check_line([head | tail]), do: [check_three(head) | check_line(tail)]
  defp check_line([]), do: []

  defp convert_to_columns([a, b, c, d, e, f, g, h, i]), do: [[a, d, g], [b, e, h], [c, f, i]]
  defp convert_to_diagonals([a, _b, c, _d, e, _f, g, _h, i]), do: [[a, e, i], [g, e, c]]
  defp convert_to_rows(board), do: Enum.chunk(board, 3)

  def get_winner(game) do
    winner =
    game.board
    |> convert_to_diagonals
    |> check_line
    |> Enum.find(&(&1)) ||
    game.board
    |> convert_to_rows
    |> check_line
    |> Enum.find(&(&1)) ||
    game.board
    |> convert_to_columns
    |> check_line
    |> Enum.find(&(&1)) 

    %{game | winner: winner} 
  end

  def is_tie?(game), do: Board.available_spaces(game.board) |> length == 0

  def game_over?(game) do  
    cond do
      get_winner(game).winner() ->
        true
      is_tie?(game) ->
        true
      true ->
        false
    end
  end

  def change_turn(game, %Player{}), do: %{ game | current_player: %Computer{}}
  def change_turn(game, %Computer{}), do: %{ game | current_player: %Player{}}

  def mark_spot(game, space) do
    %{game | board: Board.make_mark(game.board, space, game.current_player.mark)}
  end
end