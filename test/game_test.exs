defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "struct" do 
    assert %Game{} == %Game{player_1: %Player{mark: "X"}, player_2: %Computer{mark: "O"}, current_player: %Player{mark: "X"}, winner: nil, board: [0, 1, 2, 3, 4, 5, 6, 7, 8]}
  end

  describe "when current user is the player" do
    test "change_turn to computer" do
      assert Game.change_turn(%Player{}).current_player ==  %Computer{}
    end

    test "change_turn to player" do
      %{ %Game{} | current_player: %Computer{}}
      assert Game.change_turn(%Player{}).current_player ==  %Computer{}
    end
  end

  describe "when game is not over" do
    test "board is empty" do
      assert Game.game_over?([0, 1, 2, 3, 4, 5, 6, 7, 8]) == false
    end

    test "some spaces are filled" do
      assert Game.game_over?(["X", 1, "O",
                              3, "X", 5,
                              6, 7, 8]) == false
    end
  end

  describe "when game is over" do
    test "first row win" do
      assert Game.game_over?(["O", "O", "O",
                              "O", "X", "X",
                              "X", "O", "O"]) == true
    end

    test "sencond row win" do
      assert Game.game_over?(["O", "X", "O",
                              "X", "X", "X",
                              "X", "O", "X"]) == true
    end
    
    test "third row win" do
      assert Game.game_over?(["X", "O", "O", 
                              "O", "O", "X", 
                              "X", "X", "X"]) == true
    end

    test "first column win" do
      assert Game.game_over?(["X", "X", "O", 
                              "X", "O", "X",
                              "X", "O", "X"]) == true
    end

    test "sencond column win" do
      assert Game.game_over?(["O", "X", "O", 
                              "X", "X", "X",
                              "O", "X", "X"]) == true
    end
    
    test "third column win" do
      assert Game.game_over?(["O", "X", "X",
                              "O", "O", "X",
                              "X", "O", "X"]) == true
                              
    end

    test "tie" do
      assert Game.game_over?(["X", "X", "O",
                              "O", "O", "X",
                              "X", "O", "X"]) == true
    end
  end

end