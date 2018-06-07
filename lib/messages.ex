defmodule Message do
  defstruct welcome: """
                Tic Tac Toe
                -----------
                Instructions:
                Select the spot you want to mark by entering the corresponding number.
                The first to get three marks in a row will win the game.

                You are player "X", please start the game.
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
                """

end