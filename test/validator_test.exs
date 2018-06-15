defmodule ValidatorTest do
  use ExUnit.Case

  doctest Validator

  describe "when the user is playign a 3x3 game" do
    test "return true if input is not a letter" do
      assert Validator.is_valid_input?("1", "3x3") == true
    end

    test "return false if input is a letter" do
      assert Validator.is_valid_input?("C", "3x3") == false
    end

    test "return false if input is out of bounds" do
      assert Validator.is_valid_input?("9", "3x3") == false
    end
  end

  describe "when the user is playign a 4x4 game" do
    test "return true if input is not a letter" do
      assert Validator.is_valid_input?("11", "4x4") == true
    end

    test "return false if input is a letter" do
      assert Validator.is_valid_input?("C", "4x4") == false
    end

    test "return false if input is out of bounds" do
      assert Validator.is_valid_input?("22", "4x4") == false
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