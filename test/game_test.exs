defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "struct" do 
    assert %Game{} == %Game{player_1: nil, player_2: nil, current_player: nil, winner: nil, over: false, board: []}
  end

  describe "when current user is the player" do
    test "change_turn to computer" do
      game = 
      %Game{ current_player: %Human{mark: "X"},
              player_1: %Human{mark: "X"},
              player_2: %Computer{mark: "O"}}
      assert Game.change_turn(game).current_player ==  %Computer{mark: "O"}
    end

    test "change_turn to player" do
      game = %Game{ 
        current_player: %Computer{mark: "O"},
        player_1: %Human{mark: "X"},
        player_2: %Computer{mark: "O"}}
      assert Game.change_turn(game).current_player ==  %Human{mark: "X"}
    end
  end

  describe "when game is not over" do
    test "board is empty" do
      game = %Game{
        board: [0, 1, 2, 3, 4, 5, 6, 7, 8],
        current_player: %Computer{mark: "O"},
        player_1: %Human{mark: "X"},
        player_2: %Computer{mark: "O"},
        size: 3}
      assert Game.over?(game) == false
    end

    test "some spaces are filled" do
      game = 
        %Game{board: ["X", 1, "O",
                      3, "X", 5,
                      6, 7, 8],
              player_1: %Human{mark: "X"}, 
              player_2: %Human{mark: "O"},
              size: 3}
      assert Game.over?(game) == false
    end

    test "no winners" do
      game = 
        %Game{ board: ["X", 1, "O",
                        3, "X", 5,
                        6, 7, 8],
              player_1: %Human{mark: "X"},
              player_2: %Human{mark: "O"},
               size: 3}
      assert Game.get_winner(game).winner() == nil
    end
  end

  describe "when game is over" do
    test "first row win" do
      game = 
        %Game{ board: ["O", "O", "O",
                          "O", "X", "X",
                          "X", "O", "O"], 
                player_1: %Human{mark: "X"},
                player_2: %Computer{mark: "O"},
                size: 3}
      assert Game.over?(game) == true
    end

    test "second row win" do
      game = %Game{ board: ["O", "X", "O",
                            "X", "X", "X",
                            "X", "O", "X"], 
                    player_1: %Human{mark: "X"},
                    player_2: %Computer{mark: "O"},
                    size: 3}
      assert Game.over?(game) == true
    end
    
    test "third row win" do
      game = %Game{ board: ["X", "O", "O", 
                                 "O", "O", "X", 
                                 "X", "X", "X"], 
                    player_1: %Human{mark: "X"},
                    player_2: %Computer{mark: "O"},
                    size: 3}
      assert Game.over?(game) == true
    end

    test "first column win" do
      game = %Game{board: ["X", "X", "O", 
                          "X", "O", "X",
                          "X", "O", "X"], 
                    player_1: %Human{mark: "X"},
                    player_2: %Computer{mark: "O"},
                    size: 3}
      assert Game.over?(game) == true
    end

    test "second column win" do
      game = 
        %Game{board: ["O", "X", "O", 
                      "X", "X", "X",
                      "O", "X", "X"], 
              player_1: %Human{mark: "X"},
              player_2: %Computer{mark: "O"},
              size: 3}
      assert Game.over?(game) == true
    end
    
    test "third column win" do
      game = 
        %Game{board: ["O", "X", "X",
                      "O", "O", "X",
                      "X", "O", "X"], 
              player_1: %Human{mark: "X"},
              player_2: %Computer{mark: "O"},
              size: 3}
      assert Game.over?(game) == true
                              
    end

    test "diagonal win 1" do
      game = 
        %Game{board: ["O", "X", "X",
                      "O", "X", "X",
                      "X", "O", "O"], 
              player_1: %Human{mark: "X"},
              player_2: %Computer{mark: "O"},
              size: 3}
      assert Game.over?(game) == true
                              
    end    
    
    test "diagonal win 2" do
      game = 
        %Game{board: ["X", "O", "X",
                      "O", "X", "O",
                      "X", "O", "X"], 
              player_1: %Human{mark: "X"},
              player_2: %Computer{mark: "O"},
              size: 3}
      assert Game.over?(game) == true
                              
    end

    test "tie" do
      game = 
        %Game{board: ["X", "X", "O",
                      "O", "O", "X",
                      "X", "O", "X"], 
              player_1: %Human{mark: "X"},
              player_2: %Computer{mark: "O"},
              size: 3}
      assert Game.over?(game) == true
    end
  end

  test "get X winner in diagonals " do
    game = 
      %Game{board: ["O", "X", "X",
                    "O", "X", 5,
                    "X", 7, "O"], 
            player_1: %Human{mark: "X"},
            player_2: %Computer{mark: "O"},
            size: 3}

    assert Game.get_winner(game).winner() == "X"
  end

  test "get O winner in rows" do
    game = 
      %Game{board: ["O", "O", "O",
                    "O", "X", "X",
                    "X", "O", "O"], 
            player_1: %Human{mark: "X"},
            player_2: %Computer{mark: "O"},
            size: 3}

    assert Game.get_winner(game).winner() == "O"
  end  
  
  test "get X winner" do
    game = 
      %Game{board: ["O", "X", "X",
                    "O", "X", "O",
                    "X", "O", "O"], 
            player_1: %Human{mark: "X"},
            player_2: %Computer{mark: "O"},
            size: 3}
    assert Game.get_winner(game).winner() == "X"
  end


  test "no winner" do
    game = 
      %Game{board: ["O", "X", "O",
                    "O", "O", "X",
                    "X", "O", "X"], 
            player_1: %Human{mark: "X"},
            player_2: %Computer{mark: "O"},
            size: 3}

    assert Game.get_winner(game).winner() == nil
  end


  test "mark spot" do
    game = 
      %Game{ board: ["O", "X", "O",
                    "O", 4, "X",
                    "X", "O", 8],
            current_player: %Human{mark: "X"},
            player_1: %Human{mark: "X"},
            player_2: %Computer{mark: "O"}}

    assert Game.mark_spot(game, 4) == %Game{board: ["O", "X", "O", "O", "X", "X", "X", "O", 8],
                                            current_player: %Computer{mark: "O"},
                                            over: false,
                                            player_1: %Human{mark: "X"},
                                            player_2: %Computer{mark: "O"},
                                            winner: nil}
  end
end
