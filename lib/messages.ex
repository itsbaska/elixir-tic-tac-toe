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
                """,

            spot_taken: """
                Spot is taken.
                Please try again at a different spot.
                """,

            win: """
                Computer Wins!!!
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
            enter_move: """
                Please enter your move >
                """,
            play_again: """
                Would you ike to play again? Yes or No?
                
                """

end