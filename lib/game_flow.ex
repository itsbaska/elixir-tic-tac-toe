defmodule GameFlow do

  def start(console \\ Console) do
    %Message{}.welcome 
    |> console.print
    Configuration.configure_game()
    |> loop()
  end
  
  def loop(game) do
    game |> Console.print_board
    game |> Console.turn_message
    game.current_player 
    |> Player.Move.move(game) 
    |> Game.mark_spot(game)
    |> Game.change_turn
    |> perform_turn(&loop/1)
  end
  
  def perform_turn(game, continue_game) do
    if Game.over?(game) do
      game |> Console.print_board
      %Message{}.game_over <> Console.win_message(game) |> Console.print
      Console.play_again |> restart_game
    else 
      continue_game.(game) 
    end
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
end