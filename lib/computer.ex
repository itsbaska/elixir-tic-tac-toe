defmodule Computer do
  defstruct mark: "O"
  
  def move(board, space) do
    Board.make_mark(board, space, %Computer{}.mark)
  end

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


# iex(7)> list |> Enum.min_by(fn(x) -> elem(x, 1) end)    
# {:e, -1}
# iex(8)> list |> Enum.max_by(fn(x) -> elem(x, 1) end)
# {:d, 3}

# returns the space
# def best_move(best_score)
#   best_score.max_by { |key, value| value }[0]
# end

# returns the score
# def minimax_score(game, best_score)
#   if game.current_player.marker == @marker
#     best_score.max_by { |key, value| value }[1]
#   else
#     best_score.min_by { |key, value| value }[1]
#   end
# end


end