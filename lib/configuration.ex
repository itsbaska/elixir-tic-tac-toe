defmodule Configuration do
  alias Game.Board, as: Board
  alias Player.Human, as: Human
  alias Player.Computer, as: Computer

  def configure_game(configuration \\ Configuration, console \\ Console) do
    {player_1, player_2} = configuration.get_players(console)
    board_size = configuration.get_board_size(console)

    %Game{board: Board.create(board_size), 
          size: board_size,
          player_1: player_1,
          player_2: player_2,
          current_player: player_1}
  end

  def get_board_size(console \\ Console, on_invalid_input \\ &get_board_size/1) do
    board_size = 
    console.get_board_size
    |> Validator.check_board_size
    case board_size do
      {:error, message} ->
        message |> console.print
        on_invalid_input.(console)
      {:ok, board_size_input} ->
        board_size_input
    end
  end

  def get_players(console \\ Console, on_invalid_input \\ &get_players/1) do
    game_type = 
      console.get_game_type
      |> Validator.check_game_type
    case game_type do
      {:ok, :human_vs_human} ->
        get_human_vs_human_marks()
      {:ok, :human_vs_computer} ->
        get_human_vs_computer_marks()
      {:error, message} ->
        message |> console.print
        on_invalid_input.(console)
    end
  end

  def get_human_vs_human_marks(console \\ Console, console_2 \\ Console, on_invalid_input \\ &get_human_vs_human_marks/0) do
    player_1 = %Message{}.player_1 |> get_human_mark(console)
    player_2 = %Message{}.player_2 |> get_human_mark(console_2)

    marks = 
      {player_1, player_2}
      |> Validator.check_if_mark_is_available()
    case marks do
      {:error, message} -> 
        message |> console.print
        on_invalid_input.() 
      {:ok, {mark_1, mark_2}} ->
        {%Human{mark: mark_1}, %Human{mark: mark_2}}
    end
  end

  def get_human_vs_computer_marks(console \\ Console, configuration \\ Configuration) do
    player = console.get_human_mark(%Message{}.player_1)
    computer = configuration.get_computer_mark(player)
    {%Human{mark: player}, %Computer{mark: computer}}
  end

  def get_human_mark(player, console \\ Console, on_invalid_input \\ &get_human_mark/1) do
    mark = 
      player 
      |> console.get_human_mark
      |> Validator.is_valid_mark_length?()
    case mark do
      {:error, message} -> 
        message |> console.print
        on_invalid_input.(player) 
      {:ok, mark} ->
        mark
    end
  end

  def get_computer_mark(player, configuration \\ Configuration, configuration_2 \\ Configuration) do
    case player do
      "X" -> "O"
      "x" -> "o"
      "O" -> "X"
      "o" -> "x"
      _ ->
        potential_mark = configuration.get_random_letter()
        if potential_mark == player, do: configuration_2.get_random_letter(), else: potential_mark
    end
  end

  def get_random_letter do
    Enum.random for n <- ?a..?z, do: << n :: utf8 >> |> String.upcase
  end
end