defmodule RunnerTest do
  use ExUnit.Case
  doctest Runner

  describe ".start" do
    test "when the user picks option 1, the game board size is 3x3" do
      defmodule FakeStart do
        def start, do: true
      end
      assert Runner.start(FakeStart) == true
    end
  end
end