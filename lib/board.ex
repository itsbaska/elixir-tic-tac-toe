defmodule Board do
  @winning_spaces [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  def get_board do
    [0, 1, 2, 3, 4, 5, 6, 7, 8]
  end

  def is_winning_space?(spaces) do
    Enum.member?(@winning_spaces, spaces)
  end

end
