defmodule RunnerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  

  doctest Runner

  test "start the game" do
    test_output = fn ->
      Runner.start
    end
    assert capture_io(test_output) ==  """
    
    --------------

      0   1   2
     ===+===+=== 
      3   4   5
     ===+===+=== 
      6   7   8

    --------------

    """
  end
end