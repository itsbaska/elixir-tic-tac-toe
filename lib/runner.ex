defmodule Runner do
  def start(game_flow \\ GameFlow) do
    game_flow.start()
  end
end

Runner.start()