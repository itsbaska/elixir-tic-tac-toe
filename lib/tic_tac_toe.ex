defmodule TicTacToe do
  
  def new do
    %Game{}
  end

  def start do
    Console.print(%Message{}.welcome)
    Console.print_board([0, 1, 2, 3, 4, 5, 6, 7, 8])
    game = new() 
    loop(game)
  end

  def loop(game) do
    game = 
      case game.current_player == %Player{} do
        true -> human_turn(game)
        false -> computer_turn(game)
      end

    if Game.game_over?(game) do
      Console.print(%Message{}.game_over)
      Console.play_again |> restart_game
    else 
      loop(game) 
    end
  end

  def restart_game("no"), do: Console.print(%Message{}.good_bye)

  def restart_game("n"), do: Console.print(%Message{}.good_bye)

  def restart_game("yes") do
    Console.print_board(Board.create)
    Console.print(%Message{}.rematch)          
    loop(new())
  end

  def restart_game("y") do
    Console.print_board(Board.create)
    Console.print(%Message{}.rematch)          
    loop(new())
  end

  def restart_game(_) do
    Console.print(%Message{}.invalid)        
    play_again = Console.play_again
    restart_game(play_again)
  end

  def human_turn(game) do
    user_move = get_user_move(game)
    game = Game.update(game, :board, user_move)
    Console.print_board(game.board)
    Game.change_turn(game, game.current_player)
  end

  def computer_turn(game) do
    Console.print(%Message{}.computer_turn)
    game = Computer.move(game)
    Console.print_board(game.board)
    Game.change_turn(game, game.current_player)
  end

  def get_user_move(game) do
    move = IO.gets %Message{}.enter_move
    move_int = move |> String.trim()
    case Validator.is_valid_input?(move_int) do
      true ->
        space = move_int |> Integer.parse |> elem(0)
        if Board.is_available?(game.board, space) do
          Player.move(game.board, space)
        else
          Console.print(%Message{}.spot_taken)
          get_user_move(game)
        end
      false ->
        Console.print(%Message{}.invalid_number)
        get_user_move(game)
    end
  end
end