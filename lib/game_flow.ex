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
        game |> get_user_move()
      Computer ->
        game |> Computer.move()
    end
    |> perform_turn(&loop/1)
    end
    
  def perform_turn(game, continue_game) do
    if Game.over?(game) do
      game |> Console.print_board
      %Message{}.game_over <> win_message(game) |> Console.print
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

  def restart_game(input, console \\ Console, configuration \\ Configuration, game_flow \\ GameFlow)
  def restart_game(input, console, _configuration, _game_flow) when input in ["n", "no"] do
    %Message{}.good_bye |> console.print
  end

  def restart_game(input, console, configuration, game_flow) when input in ["y", "yes"] do
    %Message{}.rematch
    |> console.print
    configuration.configure_game()
    |> game_flow.loop()
  end

  def restart_game(_, console, _configuration, _game_flow) do
    %Message{}.invalid
    |> console.print
    console.play_again
    |> restart_game
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
        if game.size == 3, do: %Message{}.invalid_number_3x3, else: %Message{}.invalid_number_4x4
        |> console.print
        game |> get_user_move
    end
  end
end