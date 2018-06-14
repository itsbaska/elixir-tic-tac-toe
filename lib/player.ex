defmodule Player do
  defstruct mark: nil

  def move(game, space) do
    Game.mark_spot(game, space)
  end
end
