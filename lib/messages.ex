defmodule Message do
  defstruct welcome: """
                Tic Tac Toe
                -----------
                Instructions:
                Select the spot you want to mark by entering the corresponding number.
                The first to get three marks in a row will win the game.

                You are player "X", please start the game.
                """,

            invalid: """
                Please enter a number between 0-8.
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
                """

end