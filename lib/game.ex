defmodule Game do
  alias Game.Board, as: Board

  defstruct player_1: nil, 
            player_2: nil, 
            current_player: nil, 
            board: [],
            size: nil

  defp winner(line) do
    possible_winner = line |> Enum.dedup
    if possible_winner |> length > 1, do: nil, else: possible_winner |> List.first
  end

  defp check_line([line | rest_of_the_board]), do: [winner(line) | check_line(rest_of_the_board)]
  defp check_line([]), do: []

  defp convert_to_columns(game) do
    game
    |> convert_to_rows
    |> Enum.zip
    |> Enum.map(fn(col) -> col 
    |> Tuple.to_list end)
  end

  defp convert_to_diagonals(game) do
    diagonal_1 = Enum.take_every(game.board, game.size + 1)
    diagonal_2 =
      game 
      |> convert_to_columns 
      |> Enum.reverse 
      |> List.flatten 
      |> Enum.take_every(game.size + 1)
    [diagonal_1] ++ [diagonal_2]
  end


  defp convert_to_rows(game) do
    Enum.chunk(game.board, game.size)
  end

  def get_winner(game) do
    diagonals = 
      convert_to_diagonals(game)
        |> check_line
        |> Enum.find(&(&1))
    rows = 
      convert_to_rows(game)
        |> check_line
        |> Enum.find(&(&1))
    columns =
      convert_to_columns(game)
        |> check_line
        |> Enum.find(&(&1)) 
    diagonals || rows || columns
  end

  def is_tie?(game), do: Board.available_spaces(game) |> length == 0

  def over?(game) do  
    if get_winner(game) || is_tie?(game), do: true, else: false
  end

  def change_turn(game) do
    player =
      if game.current_player == game.player_2, do: game.player_1, else: game.player_2
    %{ game | current_player: player}
  end

  def mark_spot(space, game) do
    %{game | board: Board.make_mark(game, space)}
  end
end