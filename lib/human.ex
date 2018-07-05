defmodule Player.Human do
  defstruct Player.fields
  alias Game.Board, as: Board

  def get_user_move(game, console \\ Console, human_player \\ Player.Human) do
    move = console.get_move
    move
    |> Validator.is_valid_input?(game.size)
    |> human_player.set_user_move(move, game, &get_user_move/2, console)
  end

  def set_user_move(valid?, move, game, on_invalid_input, console \\ Console)

  def set_user_move(true, move, game, on_invalid_input, console) do
    space = move |> Integer.parse |> elem(0)
    if Board.is_available?(game, space) do
      space
    else
      %Message{}.spot_taken 
      |> console.print
      game 
      |> on_invalid_input.(console)
    end
  end
  
  def set_user_move(false, _move, game, on_invalid_input, console) do
    if game.size == 3, do: %Message{}.invalid_number_3x3, else: %Message{}.invalid_number_4x4
    |> console.print
    game 
    |> on_invalid_input.(console)
  end
end

defimpl Player.Move, for: Player.Human do
  def move(_current_player, game, console \\ Console) do
    Player.Human.get_user_move(game, console)
  end
end