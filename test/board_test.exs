defmodule BoardTest do
  use ExUnit.Case
  alias Game.Board, as: Board
  alias Player.Human, as: Human

  doctest Board
  describe "When the game board is 3x3" do
    test ".create returns the board" do
      assert Board.create(3) == [0, 1, 2, 3, 4, 5, 6, 7, 8]
    end

    test ".is_available? if board space is available" do
      game = %Game{board: ["X", 1, "X",
                           "X", "O", 5,
                           "O", "X", 8],
                    player_1: %Human{mark: "X"}, 
                    player_2: %Human{mark: "O"}}
      assert Board.is_available?(game, 5) == true
    end

    test ".is_available? if board space is not available" do
      game = %Game{board: ["X", 1, "X",
                           "X", "O", 5,
                           "O", "X", 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"}}
      assert Board.is_available?(game, 6) == false
    end

    test "mark board with player marker" do
      assert Board.make_mark(%Game{ board: ["X", 1, "X", 
                                            "X", "O", 5,
                                            6, "X", 8],
                                    current_player: %Human{mark: "O"}}, 6) == ["X", 1, "X",
                                                                                "X", "O", 5,
                                                                                "O", "X", 8]
    end

    test "returns all available spaces" do
      game = %Game{board: ["X", 1, "X",
                           "X", "O", 5,
                           6, "X", 8],
                  player_1: %Human{mark: "X"},
                  player_2: %Human{mark: "O"}}
      assert Board.available_spaces(game) == [1, 5, 6, 8]
    end

    test "returns the number of available spaces" do
      game = %Game{board: ["X", 1, "X",
                           "X", "O", 5,
                           6, "X", 8],
            player_1: %Human{mark: "X"},
            player_2: %Human{mark: "O"}}
      assert Board.available_spaces_number(game) == 4
    end
  end

  describe "When the game board is 4x4" do
    test "returns the board" do
      assert Board.create(4) == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    end

    test "returns true if board space is available" do
      game = %Game{board: ["X", 1, "X", "X",
                           "O", 5, "O", "X",
                           8, 9, 10, 11,
                           12, 13, 14, 15],
                    player_1: %Human{mark: "X"}, 
                    player_2: %Human{mark: "O"}}
      assert Board.is_available?(game, 5) == true
    end

    test "returns false if board space is not available" do
      game = %Game{board: ["X", 1, "X", "X",
                           "O", 5, "O", "X",
                           8, 9, 10, 11,
                           12, 13, 14, 15],
                    player_1: %Human{mark: "X"}, 
                    player_2: %Human{mark: "O"}}
      assert Board.is_available?(game, 6) == false
    end

    test "mark board with player marker" do
      game = %Game{board: ["X", 1, "X", "X",
                           "O", 5, 6, "X",
                           8, 9, 10, 11,
                           12, 13, 14, 15],
                    player_1: %Human{mark: "X"}, 
                    player_2: %Human{mark: "O"},
                    current_player: %Human{mark: "O"}}
      assert Board.make_mark(game, 6) == ["X", 1, "X", "X",
                                          "O", 5, "O", "X",
                                          8, 9, 10, 11,
                                          12, 13, 14, 15]
    end

    test "returns all available spaces" do
      game = %Game{board: ["X", 1, "X", "X",
                           "O", 5, 6, "X",
                           8, 9, 10, 11,
                           12, 13, 14, 15],
                    player_1: %Human{mark: "X"}, 
                    player_2: %Human{mark: "O"}}
      assert Board.available_spaces(game) == [1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15]
    end

    test "returns the number of available spaces" do
      game = %Game{board: ["X", 1, "X", "X",
                           "O", 5, 6, "X",
                           8, 9, 10, 11,
                           12, 13, 14, 15],
      player_1: %Human{mark: "X"}, 
      player_2: %Human{mark: "O"}}
      assert Board.available_spaces_number(game) == 11
    end
  end
end
