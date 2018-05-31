defmodule Computer do
  defstruct mark: "O"

  def move(game) do
    # add get_best_move call here
    Game.mark_spot(game, get_best_move(game))
  end

  def score(game) do
    cond do
      Game.get_winner(game).winner() == %Computer{}.mark() ->
        1
      Game.get_winner(game).winner() == %Player{}.mark() ->
        -1
      Game.is_tie?(game) ->
        0
    end
  end

  def minimax_score("O", scores) do
    scores |> Enum.max_by(fn(x) -> elem(x, 1) end) |> elem(1)
  end

  def minimax_score("X", scores) do
    scores |> Enum.min_by(fn(x) -> elem(x, 1) end) |> elem(1)
  end

  def best_move(scores) do
    scores |> Enum.max_by(fn(x) -> elem(x, 1) end) |> elem(0)
  end

  def get_best_move(game, scores \\ []) do
    if game.over == true do
      score(game.board)
    else
      available_spaces = game.board 
        |> Board.available_spaces
      loop_scores(game, available_spaces, [])
    end
  end

  def implement_fake_move(game, space, scores) do
    game = Game.mark_spot(game, space)
    scores ++ {space, get_best_move(game, [])}
    game = Game.change_turn(game, game.current_player)
    %{game | board: Board.reset_space(game.board, space)}
  end

  def loop_scores(game, [space | rest], scores) do
    [implement_fake_move(game, space, scores) | loop_scores(game, rest, scores)]
  end

  def loop_scores(game, [], scores) do
    []
  end
  
end