defmodule Game do
  defstruct player_1: nil, 
            player_2: nil, 
            current_player: nil, 
            winner: nil, 
            board: [],
            over: false,
            type: nil
            
  defp check_win([x, x, x]), do: x
  defp check_win([_a, _b, _c]), do: nil

  defp check_win([x, x, x, x]), do: x
  defp check_win([_a, _b, _c, _d]), do: nil

  defp check_line([head | tail]), do: [check_win(head) | check_line(tail)]
  defp check_line([]), do: []

  defp convert_to_columns([a, b, c, d, e, f, g, h, i]), do: [[a, d, g], [b, e, h], [c, f, i]]
  defp convert_to_columns([a, b, c, d, e, f, g, h, i ,j, k, l, m, n, o, p]), do: [[a, e, i, m], [b, f, j, n], [c, g, k, o], [d, h, l, p]]

  defp convert_to_diagonals([a, _b, _c, d, _e, f, g, _h, _i, j, k, _l, m, _n, _o, p]), do: [[a, f, k, p], [d, g, j, m]]
  defp convert_to_diagonals([a, _b, c, _d, e, _f, g, _h, i]), do: [[a, e, i], [g, e, c]]

  defp convert_to_rows(board = [_, _, _, _, _, _, _, _, _]), do: Enum.chunk(board, 3)
  defp convert_to_rows(board = [_, _, _, _, _, _, _, _, _,_, _, _, _, _, _, _]), do: Enum.chunk(board, 4)

  def get_winner(game) do
    diagonals = 
      game.board
        |> convert_to_diagonals
        |> check_line
        |> Enum.find(&(&1))
    rows = 
      game.board
        |> convert_to_rows
        |> check_line
        |> Enum.find(&(&1))
    columns =
      game.board
        |> convert_to_columns
        |> check_line
        |> Enum.find(&(&1)) 
    winner = diagonals || rows || columns
    over =
      case winner do 
        nil -> false
        "O" -> true
        "X" -> true
      end
    %{game | winner: winner, over: over} 
  end

  def is_tie?(game), do: Board.available_spaces(game.board) |> length == 0

  def over?(game) do  
    cond do
      get_winner(game).winner() -> true
      is_tie?(game) -> true
      true -> false
    end
  end

  def change_turn(game) do
    game.current_player
    player =
    if game.current_player == game.player_2 do
      game.player_1
    else
      game.player_2
    end 
    update(game, :current_player, player)
  end

  def update(game, :current_player, value), do: %{ game | current_player: value}
  def update(game, :player_1, value), do: %{ game | player_1: value}
  def update(game, :player_2, value), do: %{ game | player_2: value}
  def update(game, :winner, value), do: %{ game | winner: value}
  def update(game, :board, value), do: %{ game | board: value}

  def mark_spot(game, space) do
    %{game | board: Board.make_mark(game.board, space, game.current_player.mark)}
  end
end