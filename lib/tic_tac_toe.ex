defmodule TicTacToe do

  def start do
    %Message{}.welcome 
    |> Console.print
    configure_game()
    |> loop()
  end

  def configure_game do
    {player_1, player_2} = get_game_type() |> set_players
    board_size = get_board_size()
    %{%Game{} | board: Board.create(board_size), type: board_size, player_1: player_1, player_2: player_2, current_player: player_1}
  end

  def get_game_type do
    game_type_input = Console.get_game_type
    if game_type_input |> Validator.is_valid_option? do
      if game_type_input == "1", do: "human_vs_human", else: "human_vs_computer"
    else
      %Message{}.invalid |> Console.print
      get_game_type()
    end
  end

  def get_board_size do
    board_size_input = Console.get_board_size
    if board_size_input |> Validator.is_valid_option? do
      if board_size_input == "1", do: "3x3", else: "4x4"
    else
      %Message{}.invalid |> Console.print
      get_board_size()
    end
  end

  def set_players("human_vs_human") do
    {%Player{mark: "X"}, %Player{mark: "O"}}
  end

  def set_players("human_vs_computer") do
    {%Player{mark: "X"}, %Computer{mark: "O"}}
  end

  def set_board(board_size) do
    board_size |> Board.create |> Console.print_board
    Board.create(board_size)
  end
  
  def loop(game) do
    game.board |> Console.print_board
    %player{} = %Player{}
    %current_player{} = game.current_player
    game = 
      if current_player == player, do: human_turn(game), else: computer_turn(game)
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

  def win_message(nil) do
    %Message{}.tie |> Console.print
  end

  def win_message(winner) do
    winner <> %Message{}.win |> Console.print
  end

  def restart_game("no"), do: %Message{}.good_bye |> Console.print
  def restart_game("n"), do: %Message{}.good_bye |> Console.print

  def restart_game("yes") do
    %Message{}.rematch
    configure_game()
    |> loop()
  end

  def restart_game("y") do
    %Message{}.rematch
    configure_game()
    |> loop()
  end

  def restart_game(_) do
    %Message{}.invalid
    |> Console.print
    Console.play_again
    |> restart_game
  end

  def human_turn(game) do
    game = game |> get_user_move(game.type)
    game.board |> Console.print_board
    game |> Game.change_turn
  end

  def computer_turn(game) do
    %Message{}.computer_turn |> Console.print
    game = Computer.move(game)
    game.board |> Console.print_board
    game |> Game.change_turn
  end

  def get_user_move(game, board_size) do
    move = Console.get_move
    case Validator.is_valid_input?(move, board_size) do
      true ->
        space = move |> Integer.parse |> elem(0)
        if Board.is_available?(game.board, space) do
          Player.move(game, space)
        else
          %Message{}.spot_taken |> Console.print
          game |> get_user_move(board_size)
        end
      false ->
        %Message{}.invalid_number |> Console.print
        game |> get_user_move(board_size)
    end
  end
end