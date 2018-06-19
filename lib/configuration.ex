defmodule Configuration do

  def configure_game do
    {player_1, player_2} = get_players()
    board_size = get_board_size()
    %Game{board: Board.create(board_size), 
          size: board_size,
          player_1: player_1,
          player_2: player_2,
          current_player: player_1}
  end

  def get_players(console \\ Console) do
    game_type_input = console.get_game_type
    if game_type_input |> Validator.is_valid_option? do
      game_type_input 
      |> Integer.parse 
      |> elem(0) 
      |> get_marks()
    else
      %Message{}.invalid |> console.print
      get_players()
    end
  end
  
  def get_marks(game_type, console \\ Console, console_2 \\ Console)

  def get_marks(1, console, console_2) do
    %Message{}.player_1 |> console.print
    player_1 = %Player{mark: get_player_marks(console)}
    %Message{}.player_2 |> console.print
    player_2 = %Player{mark: get_player_marks(console)}

    if Validator.is_already_used?(player_1.mark, player_2.mark) do
      %Message{}.cannot_match |> console.print
      {player_1, %Player{mark: get_player_marks(console_2)}}
    else
      {player_1, player_2}          
    end
  end

  def get_marks(2, console, _console) do
    player = get_player_marks(console)
    case player do
      "X" -> 
        {%Player{mark: player}, %Computer{mark: "O"}}
      "x" ->
        {%Player{mark: player}, %Computer{mark: "o"}}
      "O" -> 
        {%Player{mark: player}, %Computer{mark: "X"}}
      "o" ->
        {%Player{mark: player}, %Computer{mark: "x"}}
      _ ->
        computer = get_random_letter()
        if computer == player do
          {%Player{mark: player}, %Computer{mark: get_random_letter()}}
        else
          {%Player{mark: player}, %Computer{mark: computer}}
        end
    end
  end

  def get_random_letter do
    Enum.random for n <- ?a..?z, do: << n :: utf8 >> |> String.upcase
  end

  def get_player_marks(console \\ Console) do
    mark = console.get_player_marks()
    if Validator.is_blank?(mark) do
      %Message{}.cannot_be_blank |> console.print
      get_player_marks()
    else
      if Validator.is_valid_length?(mark) do
        mark
      else
        %Message{}.mark_length |> console.print
        get_player_marks(console)
      end
    end
  end

  def get_board_size(console \\ Console) do
    board_size_input = console.get_board_size
    if board_size_input |> Validator.is_valid_option? do
      case board_size_input do
        "1" -> 3
        "2" -> 4
      end
    else
      %Message{}.invalid |> console.print
      get_board_size()
    end
  end
end