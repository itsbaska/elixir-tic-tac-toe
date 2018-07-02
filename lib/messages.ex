defmodule Message do
  defstruct welcome: """
              Tic Tac Toe
              -----------
              """,
            board_size: """
              Select the game board size:
              1) 3x3
              2) 4x4
              """,
            player_1: "Player 1 ~ ",
            player_2: "Player 2 ~ ",
            cannot_match: """
              Marks cannot be the same. Player 2, please choose a different mark.

              """,
            cannot_be_blank: """
              Marks cannot be blank. Please enter a mark.
              
              """,
            game_type: """
              Select game type:
              1) Human VS Human
              2) Human VS Computer
              """,
            get_player_marks: """
              Please select a single letter, number, or symbol to be your mark.
              """,
            instructions: """
              Instructions:
              Select the spot you want to mark by entering the corresponding number.
              The first to get three marks in a row will win the game.
              
              """,
            invalid_number_3x3: """
              Please enter a number between 0-8.
              """,
            invalid_number_4x4: """
              Please enter a number between 0-15.
              """,
            invalid: """
              I didn't quite get that...
              Please try again.

              """,
            mark_length: """
              Mark cannot be more than 1 character long.
              Please try again.
              """,

            spot_taken: """
              Spot is taken.
              Please try again at a different spot.
              """,
            win: """
              , is winner!!!

              """,
            tie: """
              It's a Tie!!!
              """,
            game_over: """
              -----  GAME OVER  -----

              """,

            good_bye: """
              Bye bye ~
              """,

            rematch: """
              Rematch!

              """,
            computer_turn: """
              Computers turn...
              """,
            player_1_turn: """
              Player 1 turn...
              """,
            player_2_turn: """
              Player 2 turn...
              """,
            enter_move: """
              Please enter your move >
              """,
            play_again: """
              Would you like to play again? Yes or No?
              
              """
  def turn(game) do
    %current_player{} = game.current_player
    cond do
    current_player == Player.Computer -> 
        %Message{}.computer_turn
    game.current_player == game.player_1 ->
        %Message{}.player_1_turn
    game.current_player == game.player_2 ->
        %Message{}.player_2_turn
    end
  end
end