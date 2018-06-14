defmodule Game do
  defstruct player_1: nil, 
            player_2: nil, 
            current_player: nil, 
            winner: nil, 
            board: [],
            over: false,
            size: nil
            
  defp check_win(line) do
    possible_winner = line |> Enum.dedup
    if possible_winner |> length > 1, do: nil, else: possible_winner |> List.first
  end

  defp check_line([line | rest_of_the_board]), do: [check_win(line) | check_line(rest_of_the_board)]
  defp check_line([]), do: []

  defp convert_to_columns(board, size), do: convert_to_rows(board, size) |> Enum.zip |> Enum.map(fn(col) -> col |> Tuple.to_list end)

  defp convert_to_diagonals([a, _b, _c, d, _e, f, g, _h, _i, j, k, _l, m, _n, _o, p]), do: [[a, f, k, p], [d, g, j, m]]
  defp convert_to_diagonals([a, _b, c, _d, e, _f, g, _h, i]), do: [[a, e, i], [g, e, c]]

  defp convert_to_rows(board, size), do: Enum.chunk(board, size)

  def get_winner(game) do
    diagonals = 
      convert_to_diagonals(game.board)
        |> check_line
        |> Enum.find(&(&1))
    rows = 
      convert_to_rows(game.board, game.size)
        |> check_line
        |> Enum.find(&(&1))
    columns =
      convert_to_columns(game.board, game.size)
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