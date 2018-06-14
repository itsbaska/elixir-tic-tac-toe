defmodule ValidatorTest do
  use ExUnit.Case

  doctest Validator

  describe "when user inputs a letter" do
    test "return true if input is not a letter" do
      assert Validator.is_valid_input?("1") == true
    end

    test "return false if input is a letter" do
      assert Validator.is_valid_input?("C") == false
    end

    test "return false if input is out of bounds" do
      assert Validator.is_valid_input?("9\n") == false
    end
  end

  describe "when a user inputs a non existing option" do
    test "return false if not an option" do
      assert Validator.is_valid_option?("3") == false
    end

    test "return true if valid option" do
      assert Validator.is_valid_option?("2") == true
    end
  end
  
end