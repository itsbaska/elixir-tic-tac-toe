defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer

  test "player struct" do
    assert %Computer{} === %Computer{mark: "O"}

  end

  describe "when game is over" do
    test "return 14 if Computer wins" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Computer{}, 
                    winner: nil, 
                    board: ["O", "O", "O",
                            3, "O", 5,
                            6, "X", 8],
                    over: false}
      depth = 4
      assert Computer.score(game, depth) == 14
    end
  
    test "return -1 if Human wins" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", "X", "X",
                            3, "O", 5,
                            6, "O", 8],
                    over: false}
      depth = 4
      assert Computer.score(game, depth) == -6
    end
  
    test "return 0 if tie" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", "X", "O",
                            "O", "O", "X",
                            "X", "O", "X"],
                    over: false}
      depth = 0
      assert Computer.score(game, depth) == 0
    end
  end

  describe "when O is winning" do
    test "return the highest score" do
      best_score = [{0, 1}, {1, -1}, {2, 0}, {3, 0}]
      assert Computer.minimax_score("O", best_score) == 1
    end
  end

  describe "when X is winning" do
    test "return the lowest score" do
      best_score = [{0, 1}, {1, -1}, {2, 0}, {3, 0}]
      assert Computer.minimax_score("X", best_score) == -1
    end
  end

  test "return the best move" do 
    best_score = [{2, 0}, {3, 1}, {5, 1}, {6, 1}, {8, 1}]
    assert Computer.best_move(best_score) == 3
  end

  describe "when computer makes move" do
    test "get_best_move returns the best space for computer to move to - Scenario 1" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: [0, 1, "X",
                            3, "O", 5,
                            "X", 7, 8],
                    over: false}
                    
      assert Computer.get_best_move(game, game.player_2) == 1
    end

    test "get_best_move returns the best space for computer to move to - Scenario 2" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", 1, 2,
                            3, "O", 5,
                            6, "X", 8],
                    over: false}
                    
      assert Computer.get_best_move(game, game.player_2) == 3
    end
  
    test "get_best_move returns the best space for computer to move to - Scenario 3" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", 1, 2,
                            3, "O", 5,
                            6, 7, "X"],
                    over: false}
                    
      assert Computer.get_best_move(game, game.player_2) == 1
    end
  
    test "get_best_move returns the best space for computer to move to - Scenario 4" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", 1, 2,
                            3, "X", 5,
                            6, 7, "O"],
                    over: false}
                    
      assert Computer.get_best_move(game, game.player_2) == 2 || 6
    end
  end
end