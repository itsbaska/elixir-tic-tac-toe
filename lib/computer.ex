defmodule Computer do
  defstruct mark: "O"


  def move(game) do
    # add get_best_move call here
    Game.mark_spot(game, get_best_move(game, game.current_player))
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

  def get_best_move(game, player, scores \\ [], depth \\ 0) do
    if Game.game_over?(game) == true do
      IO.puts "I ended"
       score(game)
    else
      available_spaces = game.board |> Board.available_spaces
      Enum.map(available_spaces, fn(space) -> 
        game = Game.mark_spot(game, space)
        [{space, get_best_move(game, game.current_player, [], depth + 1)} | scores]
        game = Game.change_turn(game, game.current_player)
        %{game | board: Board.reset_space(game.board, space)}
      end)
      IO.inspect minimax_score(game.current_player.mark, scores)
      # loop_scores(game, available_spaces, [])
      
    end
  end

  # def implement_fake_move(game, space, scores) do
  #   game = Game.mark_spot(game, space)
    
  #   IO.inspect [{space, get_best_move(game, [])} | scores]
  #   game = Game.change_turn(game, game.current_player)
  #   %{game | board: Board.reset_space(game.board, space)}
  # end

  # def loop_scores(game, [space | rest], scores) do
  #   IO.inspect implement_fake_move(game, space, scores)
  #   [implement_fake_move(game, space, scores) | loop_scores(game, rest, scores)]
  # end

  # def loop_scores(game, [], scores) do
  #   IO.puts "1"
  #   []
  # end
  
end