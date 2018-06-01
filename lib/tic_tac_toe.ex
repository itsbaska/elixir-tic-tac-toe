defmodule TicTacToe do
  # import ExUnit.CaptureIO
  
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
    if game.current_player == %Player{} do
      game = human_turn(game)
    else
      game = computer_turn(game)
    end
    
    if Game.game_over?(game.board) do
      Console.print("Game Over!")
    else 
      loop(game) 
    end
  end

  def human_turn(game) do
    user_move = get_user_move(game)
    game = Game.update(game, :board, user_move)
    Console.print_board(game.board)
    Game.change_turn(game, game.current_player)
  end

  def computer_turn(game) do
    Console.print("\nComputers turn")
    com_move = Computer.move(game.board, 1)
    game = Game.update(game, :board, com_move)
    Console.print_board(game.board)
    Game.change_turn(game, game.current_player)
  end

  def get_user_move(game) do
    move = IO.gets "Please enter your move > "
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
        Console.print(%Message{}.invalid)
        get_user_move(game)
    end
  end
end