defmodule Player do
  @fields mark: nil
  defstruct @fields
  def fields, do: @fields
end


defimpl GameFlow.Move, for: Game do
  def move(game) do
    %current_player{} = game.current_player
    game |> current_player.move()
  end
end