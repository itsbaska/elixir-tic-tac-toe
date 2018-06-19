defmodule GameFlow do

  def start(console \\ Console) do
    %Message{}.welcome 
    |> console.print
    Configuration.configure_game()
    |> loop()
  end
  
  def loop(game) do
    game |> Console.print_board
    game |> turn_message
    %current_player{} = game.current_player
    case current_player do
      Player ->
        human_turn(game)
      Computer ->
        computer_turn(game)
    end
    |> perform_turn(&loop/1)
    end
    
  def perform_turn(game, continue_game) do
    if Game.over?(game) do
      game |> Console.print_board
      %Message{}.game_over |> Console.print
      game |> win_message |> Console.print
      Console.play_again |> restart_game
    else 
      continue_game.(game) 
    end
  end

  def win_message(game) do
    winner = Game.get_winner(game).winner
    if winner == nil, do: %Message{}.tie, else: winner <> %Message{}.win
  end

  def turn_message(game) do
    %current_player{} = game.current_player
    cond do
      current_player == Computer -> 
        %Message{}.computer_turn
      game.current_player == game.player_1 ->
        %Message{}.player_1_turn
      game.current_player == game.player_2 ->
        %Message{}.player_2_turn
    end
    |> Console.print
  end

  def restart_game(input, console \\ Console, tictactoe \\ TicTacToe)
  def restart_game(input, console, _tictactoe) when input in ["n", "no"] do
    %Message{}.good_bye |> console.print
  end

  def restart_game(input, console, tictactoe) when input in ["y", "yes"] do
    %Message{}.rematch |> console.print
    tictactoe.configure_game()
    |> tictactoe.loop()
  end

  def restart_game(_, console, _tictactoe) do
    %Message{}.invalid
    |> console.print
    console.play_again
    |> restart_game
  end

  def human_turn(game) do
    game 
    |> get_user_move
    |> Game.change_turn
  end

  def computer_turn(game) do
    game
    |> Computer.move
    |> Game.change_turn
  end

  def get_user_move(game, console \\ Console) do
    move = console.get_move
    case Validator.is_valid_input?(move, game.size) do
      true ->
        space = move |> Integer.parse |> elem(0)
        if Board.is_available?(game, space) do
          Player.move(game, space)
        else
          %Message{}.spot_taken |> console.print
          game |> get_user_move
        end
      false ->
        if game.size == 3 do
          %Message{}.invalid_number |> console.print
        else
          %Message{}.invalid_number_2 |> console.print
        end
        game |> get_user_move
    end
  end
end