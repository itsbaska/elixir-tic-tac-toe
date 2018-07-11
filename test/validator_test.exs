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

  describe ".is_a_digit" do
    test "user inputs correct input" do
      assert Validator.is_a_digit?("1") == true
    end

    test "user inputs letter" do
      assert Validator.is_a_digit?("C") == false
    end

    test "user inputs number that is out of bounds" do
      assert Validator.is_a_digit?("*") == false
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
  
  describe ".check_board_size" do
    test "user inputs a non existing option" do
      assert Validator.check_board_size("3") == {:error, %Message{}.invalid}
    end

    test "user chooses 3x3 board" do
      assert Validator.check_board_size("1") == {:ok, 3}
    end

    test "user chooses 4x4 board" do
      assert Validator.check_board_size("2") == {:ok, 4}
    end
  end
  
  describe ".check_game_type" do
    test "user inputs a non existing option" do
      assert Validator.check_game_type("3") == {:error, %Message{}.invalid}
    end

    test "user chooses human vs human game" do
      assert Validator.check_game_type("1") ==  {:ok, :human_vs_human}
    end

    test "user chooses human vs computer game" do
      assert Validator.check_game_type("2") ==  {:ok, :human_vs_computer}
    end
  end
  
  describe ".check_if_mark_is_available" do
    test "when both users enter the same marks" do
      assert Validator.check_if_mark_is_available({"3", "3"}) == {:error, %Message{}.cannot_match}
    end

    test "when user marks are different" do
      assert Validator.check_if_mark_is_available({"2", "X"}) == {:ok, {"2", "X"}}
    end
  end

  describe ".is_less_than_two_digit?" do
    test "when user enters a digit with 1 length" do
      assert Validator.is_less_than_two_digit?("1") == true
    end

    test "when user enters a digit with length longer than 1" do
      assert Validator.is_less_than_two_digit?("222") == false
    end

    test "when user enters a letter" do
      assert Validator.is_less_than_two_digit?("d") == false
    end
  end


  describe ".is_valid_length?" do
    test "when user enters a mark with 1 length" do
      assert Validator.is_valid_length?("X") == true
    end

    test "when user enters a mark with length longer than 1" do
      assert Validator.is_valid_length?("XXX") == false
    end
  end

  describe ".is_valid_mark_length?" do
    test "when user enters a mark with 1 length" do
      assert Validator.is_valid_mark_length?("X") == {:ok, "X"}
    end

    test "when user enters a mark with length longer than 1" do
      assert Validator.is_valid_mark_length?("XXX") == {:error, %Message{}.mark_length}
    end
  end

end