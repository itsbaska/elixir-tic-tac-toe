defmodule GameFlowTest do
  use ExUnit.Case
  doctest GameFlow

  describe ".restart_game" do
    test "when the user enters 'no'" do
      defmodule PicksOptionNo do
        def print(_message), do: %Message{}.good_bye
      end
      assert GameFlow.restart_game("no", PicksOptionNo) == %Message{}.good_bye
    end

    test "when the user enters 'n'" do
      defmodule PicksOptionN do
        def print(_message), do: %Message{}.good_bye
      end
      assert GameFlow.restart_game("n", PicksOptionN) == %Message{}.good_bye
    end

    test "when the user enters 'yes'" do
      defmodule PicksOptionYes do
        def print(_message), do: nil
      end

      defmodule FakeGameFlow do
        def configure_game, do: nil
      end
      
      defmodule FakeLoop_1 do
        def loop(_), do: "restarting game"
      end

      assert GameFlow.restart_game("yes", PicksOptionYes, FakeGameFlow, FakeLoop_1) == "restarting game"
    end

    test "when the user enters 'y'" do
      defmodule PicksOptionY do
        def print(_message), do: nil
      end

      defmodule FakeGameFlow2 do
        def configure_game, do: nil
      end
      
      defmodule FakeLoop_2 do
        def loop(_), do: "restarting game"
      end
      assert GameFlow.restart_game("y", PicksOptionY, FakeGameFlow2, FakeLoop_2) == "restarting game"
    end
  end
end