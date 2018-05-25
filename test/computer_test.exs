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
  end

  describe "when O is winning" do
    test "return the highest score" do
      best_score = [{0, 1}, {1, -1}, {2, 0}, {0, 0}]
      
      assert Computer.minimax_score("O", best_score) == 1
    end
  end

  describe "when X is winning" do
    test "return the lowest score" do
      best_score = [{0, 1}, {1, -1}, {2, 0}, {0, 0}]
      assert Computer.minimax_score("X", best_score) == -1
    end
  end
  # describe "when game is not over" do
  #   test "return 0 if tie" do
  #     assert Computer.score(["X", "X", "O",
  #                            "O", 4, 5,
  #                            6, "O", "X"]) == false
  #   end
  # end
 
end