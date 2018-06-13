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

  def get_best_move(game, _player, alpha \\ 1000, beta \\ -1000, over \\ false, scores \\ [], depth \\ 0)
  
# 01 function alphabeta(node, depth, α, β, maximizingPlayer) is
# 02     if depth = 0 or node is a terminal node then
# 03         return the heuristic value of node
# 04     if maximizingPlayer then
# 05         v := -∞
# 06         for each child of node do
# 07             v := max(v, alphabeta(child, depth – 1, α, β, FALSE))
# 08             α := max(α, v)
# 09             if β ≤ α then
# 10                 break (* β cut-off *)
# 11         return v
# 12     else
# 13         v := +∞
# 14         for each child of node do
# 15             v := min(v, alphabeta(child, depth – 1, α, β, TRUE))
# 16             β := min(β, v)
# 17             if β ≤ α then
# 18                 break (* α cut-off *)
# 19         return v
# (* Initial call *)
# alphabeta(origin, depth, -∞, +∞, TRUE)

  def get_best_move(game, _player, alpha, beta, false, scores, depth) do
    available_spaces = game.board |> Board.available_spaces
    scores = Enum.map(available_spaces, fn(space) -> 
      game = Game.mark_spot(game, space) 
      |> Game.change_turn(game.current_player)
      # val = get_best_move(game, game.current_player, alpha, beta, Game.game_over?(game), [], depth + 1)
      # alpha_beta(game.current_player, val, alpha, beta)
      {space, get_best_move(game, game.current_player, alpha, beta, Game.game_over?(game), [], depth + 1)}
    end)
    if depth == 0 do
      best_move(scores)
    else
      minimax_score(game.current_player.mark, scores)
      # if game.current_player == %Computer{}, do: alpha, else: beta
    end
  end
  
  def get_best_move(game, _player, alpha, beta, true, _scores, depth) do
    score(game, depth)    
  end

  def alpha_beta(%Computer{}, val, alpha, beta) do
      alpha = 
        if val > alpha, do: val, else: alpha
      case alpha >= beta do
        false -> alpha
        true -> beta
      end 
  end

  def alpha_beta(%Player{}, val, alpha, beta) do
    beta = 
      if val < alpha, do: val, else: beta
    case beta <= alpha do
      false -> beta
      true -> alpha
    end 
  end
end