defmodule Configuration do
  alias Game.Board, as: Board
  alias Player.Human, as: Human
  alias Player.Computer, as: Computer

  def configure_game(configuration \\ Configuration, console \\ Console) do
    {player_1, player_2} = configuration.get_players(console)
    board_size = configuration.get_board_size()
    %Game{board: Board.create(board_size), 
          size: board_size,
          player_1: player_1,
          player_2: player_2,
          current_player: player_1}
  end

  def get_players(console) do
    game_type_input = console.get_game_type
      game_type_input
      |> Validator.is_valid_option? 
      |> set_players(game_type_input)
  end

  def set_players(valid?, game_type_input, console \\ Console, console2 \\ Console, on_invalid_input \\ &get_players/1)

  def set_players(true, game_type_input, console, console2, _on_invalid_input) do
    game_type_input
    |> Integer.parse 
    |> elem(0) 
    |> get_marks(console, console2)
  end

  def set_players(false, _game_type_input, console, _console2, on_invalid_input) do
    %Message{}.invalid |> console.print
    on_invalid_input.()
  end
  
  def get_player_marks(player, console \\ Console, on_invalid_input \\ &get_player_marks/3) do
    mark = player |> console.get_player_marks
    if mark |> Validator.is_blank? do
      %Message{}.cannot_be_blank
      |> console.print
      player
      |> on_invalid_input.(console)
    else
      if mark |> Validator.is_valid_length? do
        mark
      else
        %Message{}.mark_length |> console.print
        on_invalid_input.(player, console)
      end
    end
  end

  def get_marks(game_type, console \\ Console, console_2 \\ Console, on_invalid_input \\ &get_marks/3)

  def get_marks(_human_vs_human = 1, console, console_2, on_invalid_input) do
    player_1 = %Human{mark: get_player_marks(%Message{}.player_1, console)}
    player_2 = %Human{mark: get_player_marks(%Message{}.player_2, console_2)}

    if Validator.is_already_used?(player_1.mark, player_2.mark) do
      %Message{}.cannot_match |> console.print
      on_invalid_input.(1, console, console_2)
    else
      {player_1, player_2}
    end
  end


  def get_marks(_humav_vs_computer = 2, console, _console, _on_invalid_input) do
    player = get_player_marks(%Message{}.player_1, console)
    computer = 
      case player do
        "X" -> "O"
        "x" -> "o"
        "O" -> "X"
        "o" -> "x"
        _ ->
          potential_mark = get_random_letter()
          if potential_mark == player, do: get_random_letter(), else: potential_mark
      end
      {%Human{mark: player}, %Computer{mark: computer}}
  end

  def get_random_letter do
    Enum.random for n <- ?a..?z, do: << n :: utf8 >> |> String.upcase
  end

  def get_board_size(console \\ Console, on_invalid_input \\ &get_board_size/1 ) do
    board_size_input = console.get_board_size
    if board_size_input |> Validator.is_valid_option? do
      case board_size_input do
        "1" -> 3
        "2" -> 4
      end
    else
      %Message{}.invalid |> console.print
      on_invalid_input.(console)
    end
  end
end