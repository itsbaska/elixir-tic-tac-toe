defmodule Computer do
  defstruct mark: "O"

  def move(game) do
    game_type = if game.board |> length < 9, do: "3x3", else: "4x4"
    available_spaces_number = game.board |> Board.available_spaces_number
    pick_move(game_type, game, available_spaces_number)
  end

  def pick_move("3x3", game, available_spaces_number) when available_spaces_number >=7 do
    move = Enum.random(0..8)
    if Board.is_available?(game.board, move), do: Game.mark_spot(game, move), else: move(game)      
  end

  def pick_move("4x4", game, available_spaces_number) when available_spaces_number >= 13 do
    move = Enum.random(0..15)
    if Board.is_available?(game.board, move), do: Game.mark_spot(game, move), else: move(game)
  end

  def pick_move(_game_type, game, _available_space_number) do
    Game.mark_spot(game, get_best_move(game, game.current_player))
  end

  def hueristic_score(game, depth) do
    cond do
      Game.get_winner(game).winner() == %Computer{}.mark() -> 10 + depth
      Game.get_winner(game).winner() == %Player{}.mark() -> -10 + depth
      Game.is_tie?(game) -> 0
    end
  end

  def minimax_score("O", scores) do
    scores
    |> Enum.max_by(fn({_space, score}) -> score end) 
    |> elem(1)
  end

  def minimax_score("X", scores) do
    scores
    |> Enum.min_by(fn({_space, score}) -> score end) 
    |> elem(1)
  end

  def best_move(scores) do
    scores 
    |> Enum.max_by(fn({_space, score}) -> score end)
    |> elem(0)
  end

  def get_best_move(game, _player, over \\ false, scores \\ [], depth \\ 0)
  
  def get_best_move(game, _player, true, _scores, depth), do: hueristic_score(game, depth)    

  def get_best_move(game, _player, false, _scores, depth) do
    available_spaces = game.board |> Board.available_spaces
    scores = Enum.map(available_spaces, fn(space) -> 
      game = Game.mark_spot(game, space) 
      |> Game.change_turn(game.current_player)
      score =
      if depth < 4 do
        get_best_move(game, game.current_player, Game.game_over?(game), [], depth + 1)
      end
      {space, score}
    end)
    if depth == 0, do: best_move(scores), else: minimax_score(game.current_player.mark, scores)
  end
end