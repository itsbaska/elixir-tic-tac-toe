defmodule TicTacToe do
  
  def new_game(board, board_size) do
    %{%Game{} | board: board, size: board_size}
  end

  def start do
    %Message{}.welcome |> Console.print
    get_board_size()
  end

  def get_board_size do
    board_size_input = Console.get_board_size
    if board_size_input |> Validator.is_valid_option? do
      case board_size_input do
        "1" -> 3
        "2" -> 4
      end
      |> create_game
    else
      %Message{}.invalid |> Console.print
      get_board_size()
    end
  end
  
  def create_game(board_size) do
    board_size |> Board.create |> Console.print_board
    new_game(Board.create(board_size), board_size) |> loop
  end

  def loop(game) do
    game = 
      case game.current_player == %Player{} do
        true -> human_turn(game)
        false -> computer_turn(game)
      end
    perform_turn(game, &loop/1)
  end
  
  def perform_turn(game, continue_game) do
    if Game.over?(game) do
      %Message{}.game_over |> Console.print
      Game.get_winner(game).winner |> win_message
      Console.play_again |> restart_game
    else 
      continue_game.(game) 
    end
  end

  def win_message("O") do
    %Message{}.win |> Console.print
  end
    
  def win_message(nil) do
    %Message{}.tie |> Console.print
  end

  def restart_game("no"), do: %Message{}.good_bye |> Console.print
  def restart_game("n"), do: %Message{}.good_bye |> Console.print

  def restart_game("yes") do
    %Message{}.rematch
    get_board_size()
  end

  def restart_game("y") do
    %Message{}.rematch
    get_board_size()
  end

  def restart_game(_) do
    %Message{}.invalid
    |> Console.print
    Console.play_again
    |> restart_game
  end

  def human_turn(game) do
    user_move = game |> get_user_move(game.size)
    user_move |> Console.print_board
    game = Game.update(game, :board, user_move)
    game |> Game.change_turn(game.current_player)
  end

  def computer_turn(game) do
    %Message{}.computer_turn |> Console.print
    game = Computer.move(game)
    game.board |> Console.print_board
    game |> Game.change_turn(game.current_player)
  end

  def get_user_move(game, game_type) do
    move = Console.get_move
    case Validator.is_valid_input?(move, game_type) do
      true ->
        space = move |> Integer.parse |> elem(0)
        if Board.is_available?(game.board, space) do
          Player.move(game.board, space)
        else
          %Message{}.spot_taken |> Console.print
          game |> get_user_move(game_type)
        end
      false ->
        %Message{}.invalid_number |> Console.print
        game |> get_user_move(game_type)
    end
  end
end