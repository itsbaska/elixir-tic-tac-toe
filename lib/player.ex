defmodule Player do
  @fields mark: nil
  defstruct @fields
  def fields, do: @fields
end

defprotocol Player.Move do
  def move(_current_player, game, console \\ Console)
end