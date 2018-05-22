defmodule ValidatorTest do
  use ExUnit.Case
  # import ExUnit.CaptureIO

  doctest Validator

  describe "when user inputs a letter" do
    test "return true if input is not a letter" do
      assert Validator.is_valid_input("1") == true
    end

    test "return false if input is a letter" do
      assert Validator.is_valid_input("C") == false
    end

    test "return false if input is out of bounds" do
      assert Validator.is_valid_input("9") == false
    end
  end
  
end