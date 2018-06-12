defmodule Validator do
  def is_valid_input?("9\n"), do: false
  def is_valid_input?(input), do: input |> is_a_digit? && input |> is_one_digit?
  def is_a_digit?(input), do: Regex.match?(~r/\d/, input)
  def is_one_digit?(input), do: input |> String.trim |> String.length == 1
end