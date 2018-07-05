defmodule Validator do
  def is_valid_input?(input, 3) do
    input |> is_a_digit? && 
    input |> is_valid_length? && 
    input != "9"
  end

  def is_valid_input?(input, 4) do
    if input |> is_a_digit? && 
       input |> is_less_than_two_digit? do 
      {move, _} = Integer.parse(input) 
      Enum.member?(Enum.to_list(0..15), move)
    else
      false
    end
  end
  
  def is_a_digit?(input), do: Regex.match?(~r/\d/, input)
  def is_less_than_two_digit?(input), do: input |> String.length <= 2

  def check_board_size("1"), do: {:ok, 3}
  def check_board_size("2"), do: {:ok, 4}
  def check_board_size(_), do: {:error, %Message{}.invalid}

  def check_game_type("1"), do: {:ok, 1}
  def check_game_type("2"), do:  {:ok, 2}
  def check_game_type(_), do: {:error, %Message{}.invalid}



  def check_if_mark_is_available({mark_1, mark_2}) do
    if mark_1 == mark_2, do: {:error, %Message{}.cannot_match}, else: {:ok, {mark_1, mark_2}}
  end

  def is_not_blank?(""), do: false
  def is_not_blank?(mark), do: mark

  def is_valid_length?(mark), do: mark |> String.length == 1
end