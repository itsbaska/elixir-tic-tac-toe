defmodule Runner do
  def start do
    Console.print(%Message{}.welcome)
    Console.print_board([0, 1, 2, 3, 4, 5, 6, 7, 8])
  end
end

Runner.start()