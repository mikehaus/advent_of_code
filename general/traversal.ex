defmodule General.Nav do
  @moduledoc """
  Traversal module provides utilities that handle navigating a grid
  """

  defp up1(y), do: y - 1
  defp down1(y), do: y + 1
  defp left1(x), do: x + 1
  defp right1(x), do: x + 1

  defp up2(coord), do: y - 2
  defp down2(coord), do: y + 2
  defp left2(coord), do: x - 2
  defp right2(coord), do: x + 2

  def move([x, y], :slow, :n), do: [x, up1(y)]
  def move([x, y], :slow, :s), do: [x, down1(y)]
  def move([x, y], :slow, :w), do: [x, left1(y)]
  def move([x, y], :slow, :e), do: [x, right1(y)]

  def move([x, y], :slow, :n_w), do: [left1(x), up1(y)]
  def move([x, y], :slow, :n_e), do: [right1(x), up1(y)]
  def move([x, y], :slow, :s_w), do: [left1(x), down1(y)]
  def move([x, y], :slow, :s_e), do: [right1(x), down1(y)]

  def move([x, y], :fast, :north), do: [x, up2(y)]
  def move([x, y], :fast, :south), do: [x, down2(y)]
  def move([x, y], :fast, :west), do: [x, left2(y)]
  def move([x, y], :fast, :east), do: [x, right2(y)]

  def find_char_coordinates(grid, char_to_find) do
    grid
    |> Enum.with_index()
    |> Enum.map(fn {chars, y_idx} ->
      chars
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {char, x_idx} ->
        if val == char do
          [x_idx, y_idx]
        else
          nil
        end
      end)
    end)
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
  end

  # TODO: Incorporate find cycle
end
