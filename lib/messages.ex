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
            game_type: """
                Select game type:
                1) Human VS Human
                2) Human VS Computer
                """,
            instructions: """
                Instructions:
                Select the spot you want to mark by entering the corresponding number.
                The first to get three marks in a row will win the game.
                
                """,
            invalid_number: """
                Please enter a number between 0-8.
                """,
            invalid: """
                I didn't quite get that...
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
    
end