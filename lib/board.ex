defmodule Board do
  def create(size) do
    last_board_space = (size * size) - 1
    0..last_board_space |> Enum.to_list
  end

  def is_available?(game, space) do
    Enum.at(game.board, space) != game.player_1.mark and Enum.at(game.board, space) != game.player_2.mark
  end

  def make_mark(game, space) do
    List.replace_at(game.board, space, game.current_player.mark)
  end

  def available_spaces(game) do
    Enum.filter(game.board, fn(space) -> space != game.player_1.mark and space != game.player_2.mark end)
  end

  def available_spaces_number(game) do
    game
    |> available_spaces
    |> length
  end
end
