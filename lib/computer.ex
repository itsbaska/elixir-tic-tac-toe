defmodule Computer do
  defstruct mark: nil
  alias Game.Board, as: Board

  defimpl Player, for: Computer do
    def move(game) do
      Game.mark_spot(game, Computer.get_best_move(game))
    end
  end

  def get_best_move(game, over \\ false, scores \\ [], depth \\ 0)
  def get_best_move(game, true, _scores, depth), do: hueristic_score(game, depth)    
  def get_best_move(game, false, _scores, depth) do
    scores = 
      Enum.map(game |> Board.available_spaces, fn(space) ->
        game = Game.mark_spot(game, space) 
        score = if depth < 4, do: get_best_move(game, Game.over?(game), [], depth + 1)
        {space, score}
      end)
    %player{} = game.current_player
    if depth == 0, do: best_move(scores), else: minimax_score(player, scores)
  end

  def hueristic_score(game, depth) do
    %player_1{} = game.player_1
    com_player = 
      if player_1 == Computer, do: game.player_1, else: game.player_2
    hum_player =
      if player_1 == Human, do: game.player_1, else: game.player_2
    cond do
      Game.get_winner(game).winner() == com_player.mark -> 10 + depth
      Game.get_winner(game).winner() == hum_player.mark -> -10 + depth
      Game.is_tie?(game) -> 0
    end
  end

  def minimax_score(Computer, scores) do
    scores
    |> Enum.max_by(fn({_space, score}) -> score end) 
    |> elem(1)
  end

  def minimax_score(Human, scores) do
    scores
    |> Enum.min_by(fn({_space, score}) -> score end) 
    |> elem(1)
  end

  def best_move(scores) do
    scores 
    |> Enum.max_by(fn({_space, score}) -> score end)
    |> elem(0)
  end
end