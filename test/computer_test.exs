defmodule ComputerTest do
  use ExUnit.Case
  doctest Computer

  test "player struct" do
    assert %Computer{} === %Computer{mark: "O"}

  end

  describe "when game is over" do
    test "return 1 if Computer wins" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["O", "O", "O",
                            "X", "O", "X",
                            "O", "X", "O"],
                    over: false}

      assert Computer.score(game) == 1
    end
  
    test "return -1 if Human wins" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", "X", "X",
                            "X", "O", "X",
                            "O", "X", "O"],
                    over: false}

      assert Computer.score(game) == -1
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

      assert Computer.score(game) == 0
    end

    test "get_best_move returns the minimax score" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", "X", "X",
                            3, "X", "O",
                            "O", "O", 8],
                    over: false}
                    
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
  #     game = %Game{player_1: %Player{}, 
  #     player_2: %Computer{}, 
  #     current_player: %Player{}, 
  #     winner: nil, 
  #     board: [0, 1, 2, 3, 4, 5, 6, 7, 8]}
      
  #     assert Computer.get_best_move(game) == 0
  #   end
  # end

  describe "when game is not over" do
    test "get_best_move returns the minimax score" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Player{}, 
                    winner: nil, 
                    board: ["X", 1, "X",
                            3, "X", "O",
                            "O", "O", 8],
                    over: false}
      
      assert Computer.get_best_move(game, Board.available_spaces_number(game.board)) == 1
    end
  end

  # describe "when depth is equal to the available spaces" do
  #   test "get best move" do
  #     game = %Game{player_1: %Player{}, 
  #     player_2: %Computer{}, 
  #     current_player: %Player{}, 
  #     winner: nil, 
  #     board: [0, "X", "X",
  #             3, "X", "O",
  #             "O", "O", 8],
  #     over: false}
      
  #     assert Computer.get_best_move(game, [{0, 1}, {1, -1}, {2, 0}, {3, 0}]) == 0
  #   end
  # end
  

  describe "computer has chosen its spot" do
    test "mark_spot" do
      game = %Game{player_1: %Player{}, 
                    player_2: %Computer{}, 
                    current_player: %Computer{}, 
                    winner: nil, 
                    board: [0, "X", "X",
                            3, "X", "O",
                            "O", "O", 8],
                    over: false}
      
      assert Computer.move(game) == [0, "X", "X",
                                     3, "X", "O",
                                     "O", "O", "O"]
    end
  end
end