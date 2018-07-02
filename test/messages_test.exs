defmodule MessageTest do
  use ExUnit.Case
  alias Player.Human, as: Human

  doctest Message

  describe ".turn" do
    test "when Computer is current player" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Computer{mark: "o"},
                    current_player: %Player.Computer{mark: "x"}}

      assert game |> Message.turn == "Computers turn...\n"
     
    end

    test "when Human Player 1 is current player" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Human{mark: "o"},
                    current_player: %Player.Human{mark: "x"}}

      assert game |> Message.turn == "Player 1 turn...\n"
     
    end

    test "when Human Player 2 is current player" do
      game = %Game{board: ["x", "x", "o", "o", "o", "x", "o", "o", "o"], 
                    size: 3,
                    player_1: %Player.Human{mark: "x"},
                    player_2: %Player.Human{mark: "o"},
                    current_player: %Player.Human{mark: "o"}}

      assert game |> Message.turn == "Player 2 turn...\n"
    end
  end
end