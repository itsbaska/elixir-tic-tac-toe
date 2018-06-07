defmodule Computer do
  defstruct mark: "O"

  def move(game) do
    Game.mark_spot(game, get_best_move(game, game.current_player))
  end

  def score(game, depth) do
    cond do
      Game.get_winner(game).winner() == %Computer{}.mark() -> 10 + depth
      Game.get_winner(game).winner() == %Player{}.mark() -> -10 + depth
      Game.is_tie?(game) -> 0
    end
  end

  def minimax_score("O", scores) do
    scores
    |> Enum.max_by(fn(x) -> elem(x, 1) end) 
    |> elem(1)
  end

  def minimax_score("X", scores) do
    scores
    |> Enum.min_by(fn(x) -> elem(x, 1) end) 
    |> elem(1)
  end

  def best_move(scores) do
    # IO.inspect scores 
    # IO.puts "----"
    # IO.inspect Enum.max_by(scores, fn(score) -> elem(score, 1) end)
    scores 
    |> Enum.max_by(fn(score) -> elem(score, 1) end)
    |> elem(0)
  end

  def get_best_move(game, _player, scores \\ [], depth \\ 0) do
    if Game.game_over?(game) == true do
      score(game, depth)
    else
      available_spaces = game.board |> Board.available_spaces
      scores = Enum.map(available_spaces, fn(space) -> 
        game = Game.mark_spot(game, space) 
        |> Game.change_turn(game.current_player)
        {space, get_best_move(game, game.current_player, [], depth + 1)}
      end)
      if depth == 0, do: best_move(scores), else: minimax_score(game.current_player.mark, scores)
    end
  end
end