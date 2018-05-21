defmodule ElixirTicTacToe do
  def hello do
    :world
  end

  def talk do
    response = IO.gets  "Is this where we are?" 
    answer = response
    # IO.puts answer
  end
end

ElixirTicTacToe
