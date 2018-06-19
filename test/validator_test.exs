defmodule ValidatorTest do
  use ExUnit.Case

  doctest Validator

  describe ".is_valid_input, when the user is playing a 3x3 game" do
    test "user inputs correct input" do
      assert Validator.is_valid_input?("1", 3) == true
    end

    test "user inputs letter" do
      assert Validator.is_valid_input?("C", 3) == false
    end

    test "user inputs number that is out of bounds" do
      assert Validator.is_valid_input?("9", 3) == false
    end
  end

  describe ".is_valid_input, when the user is playign a 4x4 game" do
    test "user inputs a valid entry" do
      assert Validator.is_valid_input?("11", 4) == true
    end

    test "user input is a letter" do
      assert Validator.is_valid_input?("C", 4) == false
    end

    test "user input is out of bounds" do
      assert Validator.is_valid_input?("22", 4) == false
    end
  end
  
  describe ".is_valid_option?" do
    test "user inputs a non existing option" do
      assert Validator.is_valid_option?("3") == false
    end

    test "user inputs a valid existing option" do
      assert Validator.is_valid_option?("2") == true
    end
  end
  
  describe ".is_already_used?" do
    test "when both users enter the same marks" do
      assert Validator.is_already_used?("3", "3") == true
    end

    test "when user marks are different" do
      assert Validator.is_already_used?("2", "X") == false
    end
  end
end