defmodule Validator do

  def is_valid_input("9"), do: false
  def is_valid_input(input), do: Regex.match?(~r/\d/, input)

end