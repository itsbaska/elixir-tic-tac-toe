defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer

  test "player struct" do
    assert %Computer{} === %Computer{mark: "O"}

  end

  test "make move" do
    assert Computer.move(["X", "O", "X",
                          "X", "O", "O",
                          "O", "X", 8], 8) == ["X", "O", "X",
                                               "X", "O", "O",
                                               "O", "X", "O"]
  end

  describe "when game is over" do
    test "return 1 if Computer wins" do
      assert Computer.score(["O", "O", "O",
                             "X", "O", "X",
                             "O", "X", "O"]) == 1
    end
  
    test "return -1 if Human wins" do
      assert Computer.score(["X", "X", "X",
                             "X", "O", "X",
                             "O", "X", "O"]) == -1
    end
  
    test "return 0 if tie" do
      assert Computer.score(["X", "X", "O",
                             "O", "O", "X",
                             "X", "O", "X"]) == 0
    end

    test "get_best_move returns the minimax score" do
      game = %Game{player_1: %Player{mark: "X"}, 
      player_2: %Computer{mark: "O"}, 
      current_player: %Player{mark: "X"}, 
      winner: nil, 
      board: [0, 1, 2,
              3, 4, 5,
              6, 7, 8]}
      
      assert Computer.get_best_move(game) == 1
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
    best_score = [{0, 1}, {1, -1}, {2, 0}, {3, 0}]
    assert Computer.best_move(best_score) == 0
  end


  # describe "when computer makes first move" do
  #   test "get best move" do
  #     game = %Game{player_1: %Player{mark: "X"}, 
  #     player_2: %Computer{mark: "O"}, 
  #     current_player: %Player{mark: "X"}, 
  #     winner: nil, 
  #     board: [0, 1, 2, 3, 4, 5, 6, 7, 8]}
      
  #     assert Computer.get_best_move(game) == 0
  #   end
  # end

  describe "when depth is equal to the available spaces" do
    test "get best move" do
      game = %Game{player_1: %Player{mark: "X"}, 
      player_2: %Computer{mark: "O"}, 
      current_player: %Player{mark: "X"}, 
      winner: nil, 
      board: [0, "X", "X",
              3, "X", "O",
              "O", "O", 8]}
      
      assert Computer.get_best_move(game, 3, [{0, 1}, {1, -1}, {2, 0}, {3, 0}]) == 0
    end
  end
  
end