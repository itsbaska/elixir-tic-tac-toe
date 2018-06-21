defmodule Human do
  defstruct mark: nil

  defimpl Player, for: Human do
    def move(game, space) do
      Game.mark_spot(game, space)
    end
  end
end
