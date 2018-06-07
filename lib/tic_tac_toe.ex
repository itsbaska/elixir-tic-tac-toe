defmodule TicTacToe do
  
  def new_game do
    %Game{}
  end

  def start do
    %Message{}.welcome |> Console.print
    Board.create |> Console.print_board
    new_game() |> loop
  end

  def loop(game) do
    game = 
      case game.current_player == %Player{} do
        true -> human_turn(game)
        false -> computer_turn(game)
      end

    if Game.game_over?(game) do
      %Message{}.game_over |> Console.print
      Console.play_again |> restart_game
    else 
      loop(game) 
    end
  end

  def restart_game("no"), do: %Message{}.good_bye |> Console.print

  def restart_game("n"), do: %Message{}.good_bye |> Console.print

  def restart_game("yes") do
    Board.create
    |> Console.print_board
    %Message{}.rematch
    |> Console.print
    new_game() |> loop
  end

  def restart_game("y") do
    Board.create
    |> Console.print_board
    %Message{}.rematch
    |> Console.print
    new_game() |> loop
  end

  def restart_game(_) do
    %Message{}.invalid
    |> Console.print
    Console.play_again
    |> restart_game
  end

  def human_turn(game) do
    user_move = game |> get_user_move
    game = Game.update(game, :board, user_move)
    game.board |> Console.print_board
    game |> Game.change_turn(game.current_player)
  end

  def computer_turn(game) do
    %Message{}.computer_turn |> Console.print
    game = Computer.move(game)
    game.board |> Console.print_board
    game |> Game.change_turn(game.current_player)
  end

  def get_user_move(game) do
    move = 
      IO.gets %Message{}.enter_move
      |> String.trim()
    case Validator.is_valid_input?(move) do
      true ->
        space = move |> Integer.parse |> elem(0)
        if Board.is_available?(game.board, space) do
          Player.move(game.board, space)
        else
          %Message{}.spot_taken |> Console.print
          game |> get_user_move
        end
      false ->
        %Message{}.invalid_number |> Console.print
        game |> get_user_move
    end
  end
end