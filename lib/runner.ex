defmodule Runner do
  def start(tictactoe \\ TicTacToe) do
    tictactoe.start()
  end
end

Runner.start()