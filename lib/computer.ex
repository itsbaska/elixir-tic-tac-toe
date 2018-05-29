defmodule Computer do
  defstruct mark: "O"
  
  def move(board, space) do
    Board.make_mark(board, space, %Computer{}.mark)
  end

  def get_best_move(game, depth \\ 0, best_score \\ []) do
    cond do
      Game.game_over?(game) -> 
        score(game.board)
      depth == length(Board.available_spaces(game.board)) ->
        best_move(best_score)
    end
  end

  def get_best_move(game, depth, best_score) do
    Enum.map(Board.available_spaces(game.board), fn(space) ->
      game.mark_spot(game, space)
      Game.change_turn(game.current_player)
      IO.best_score
      best_score ++ get_best_move(game, depth + 1, [])
      Board.reset_space(game.board, space)
      Game.change_turn(game.current_player)
    end)
    minimax_score(game.current_player, best_score)
  end

  # Enum.map([1, 2, 3], fn(x) -> x * 2 end)
  # [2, 4, 6]

  # def get_best_move(game, depth = 0, best_score = {})
  #   return score(game) if game.game_over?
  #   game.board.available_spaces.each do |spot|
  #     game.mark_spot(spot)
  #     best_score[spot] = get_best_move(game, depth += 1, {})
  #     game.board.reset_space(spot)
  #     game.change_turns
  #   end

  #   return best_move(best_score) if depth == game.board.available_spaces.length
  #   minimax_score(game, best_score)
  # end


  def score(board) do
    cond do
      Game.get_winner(board) == "O" ->
        1
      Game.get_winner(board) == "X" ->
        -1
      Game.is_tie?(board) ->
        0
    end
  end

  def minimax_score("O", best_score) do
    best_score |> Enum.max_by(fn(x) -> elem(x, 1) end) |> elem(1)
  end

  def minimax_score("X", best_score) do
    best_score |> Enum.min_by(fn(x) -> elem(x, 1) end) |> elem(1)
  end

  def best_move(best_score) do
    best_score |> Enum.max_by(fn(x) -> elem(x, 1) end) |> elem(0)
  end
end