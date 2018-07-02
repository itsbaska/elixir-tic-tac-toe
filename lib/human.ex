defmodule Player.Human do
  defstruct Player.fields
  alias Game.Board, as: Board

  def get_user_move(game, console \\ Console) do
    move = console.get_move
    case Validator.is_valid_input?(move, game.size) do
      true ->
        space = move |> Integer.parse |> elem(0)
        if Board.is_available?(game, space) do
          space
        else
          %Message{}.spot_taken |> console.print
          game |> get_user_move
        end
      false ->
        if game.size == 3, do: %Message{}.invalid_number_3x3, else: %Message{}.invalid_number_4x4
        |> console.print
        game |> get_user_move
    end
  end
end

defimpl Player.Move, for: Player.Human do
  def move(_current_player, game, console \\ Console) do
    Game.mark_spot(game, Player.Human.get_user_move(game, console))
  end
end