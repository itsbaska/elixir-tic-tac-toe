defmodule Validator do
  def is_valid_input?("9", 3), do: false
  def is_valid_input?(input, 3), do: input |> is_a_digit? && input |> is_one_digit?

  def is_valid_input?(input, 4) do
    if input |> is_a_digit? && input |> is_less_than_two_digit? do 
      {move, _} = Integer.parse(input) 
      Enum.member?(Enum.to_list(0..15), move)
    else
      false
    end
  end

  
  def is_a_digit?(input), do: Regex.match?(~r/\d/, input)
  def is_one_digit?(input), do: input |> String.trim |> String.length == 1
  def is_less_than_two_digit?(input), do: input |> String.trim |> String.length <= 2

  def is_valid_option?("1"), do: true
  def is_valid_option?("2"), do: true
  def is_valid_option?(_), do: false

  def is_already_used?(mark_1, mark_2) do
    if mark_1 == mark_2 do
      true
    else
      false
    end
  end

  def is_blank?(""), do: true
  def is_blank?(_), do: false

  def is_valid_length?(mark), do: mark |> String.length == 1


end