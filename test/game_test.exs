defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "struct" do 
    assert %Game{} == %Game{player_1: %Player{}, player_2: %Computer{}, current_player: %Player{}, winner: nil, over: false, board: [0, 1, 2, 3, 4, 5, 6, 7, 8]}
  end

  describe "when current user is the player" do
    test "change_turn to computer" do
      game = %Game{}

      assert Game.change_turn(game, %Player{}) == %Game{player_1: %Player{},
                                                        player_2: %Computer{},
                                                        current_player: %Computer{},
                                                        winner: nil,
                                                        over: false,
                                                        board: [0, 1, 2, 3, 4, 5, 6, 7, 8]}
    end

    test "change_turn to player" do
      game = %{ %Game{} | current_player: %Computer{}}
    
      assert Game.change_turn(game, %Computer{}) == %Game{player_1: %Player{},
                                                          player_2: %Computer{},
                                                          current_player: %Player{},
                                                          winner: nil,
                                                          over: false,
                                                          board: [0, 1, 2, 3, 4, 5, 6, 7, 8]}

    end
  end

  describe "when game is not over" do
    test "board is empty" do
      assert Game.game_over?(%Game{}) == false
    end

    test "some spaces are filled" do
      game = %{%Game{} | board: ["X", 1, "O",
                                  3, "X", 5,
                                  6, 7, 8]}
      assert Game.game_over?(game) == false
    end

    test "no winners" do
      game = %{ %Game{} | board: ["X", 1, "O",
                                  3, "X", 5,
                                  6, 7, 8]}
      assert Game.get_winner(game).winner() == nil
    end
  end

  describe "when game is over" do
    test "first row win" do
      game = %{%Game{} | board: ["O", "O", "O",
                                 "O", "X", "X",
                                 "X", "O", "O"]}
      assert Game.game_over?(game) == true
    end

    test "second row win" do
      game = %{%Game{} | board: ["O", "X", "O",
                                 "X", "X", "X",
                                 "X", "O", "X"]}
      assert Game.game_over?(game) == true
    end
    
    test "third row win" do
      game = %{%Game{} | board: ["X", "O", "O", 
                                 "O", "O", "X", 
                                 "X", "X", "X"]}
      assert Game.game_over?(game) == true
    end

    test "first column win" do
      game = %{%Game{} | board: ["X", "X", "O", 
                                 "X", "O", "X",
                                 "X", "O", "X"]}
      assert Game.game_over?(game) == true
    end

    test "second column win" do
      game = %{%Game{} | board: ["O", "X", "O", 
                                 "X", "X", "X",
                                 "O", "X", "X"]}
      assert Game.game_over?(game) == true
    end
    
    test "third column win" do
      game = %{%Game{} | board: ["O", "X", "X",
                                 "O", "O", "X",
                                 "X", "O", "X"]}
      assert Game.game_over?(game) == true
                              
    end

    test "diagonal win 1" do
      game = %{%Game{} | board: ["O", "X", "X",
                                 "O", "X", "X",
                                 "X", "O", "O"]}
      assert Game.game_over?(game) == true
                              
    end    
    
    test "diagonal win 2" do
      game = %{%Game{} | board: ["X", "O", "X",
                                 "O", "X", "O",
                                 "X", "O", "X"]}
      assert Game.game_over?(game) == true
                              
    end

    test "tie" do
      game = %{%Game{} | board: ["X", "X", "O",
                                 "O", "O", "X",
                                 "X", "O", "X"]}
      assert Game.game_over?(game) == true
    end
  end

  test "get X winner in diagonals " do
    game = %{%Game{} | board: ["O", "X", "X",
                               "O", "X", 5,
                               "X", 7, "O"]}

    assert Game.get_winner(game).winner() == "X"
  end

  test "get O winner in rows" do
    game = %{%Game{} | board: ["O", "O", "O",
                               "O", "X", "X",
                               "X", "O", "O"]}

    assert Game.get_winner(game).winner() == "O"
  end  
  
  test "get X winner" do
    game = %{%Game{} | board: ["O", "X", "X",
                               "O", "X", "O",
                               "X", "O", "O"]}
    assert Game.get_winner(game).winner() == "X"
  end


  test "no winner" do
    game = %{%Game{} | board: ["O", "X", "O",
                               "X", "O", "X"]}
                               "O", "O", "X",

    assert Game.get_winner(game).winner() == nil
  end


  test "mark spot" do
    game = %{%Game{} | board: ["O", "X", "O",
                               "O", 4, "X",
                               "X", "O", 8]}

    assert Game.mark_spot(game, 4) == %Game{board: ["O", "X", "O", "O", "X", "X", "X", "O", 8],
                                            current_player: %Player{},
                                            over: false,
                                            player_1: %Player{},
                                            player_2: %Computer{},
                                            winner: nil}
                                          end
  end