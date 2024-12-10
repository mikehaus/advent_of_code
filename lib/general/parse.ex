defmodule General.Parse do
  @moduledoc """
  File and string transformation utilities
  """

  def generate_grid(filename) do
    case File.read(filename) do
      {:ok, input} -> String.split(input, "\n", trim: true)
      _ -> []
    end
    # {:ok, input} = File.read(filename)

    # input
    # |> String.split("\n", trim: true)
  end

  def split_by_delimiter(grid, delimiter) do
    grid
    |> Enum.map(fn val -> String.split(val, delimiter) end)
  end

  def reduce_into_map(values) do
    values
    |> Enum.reduce(%{}, fn [h, t], acc ->
      Map.put(acc, h, String.split(t, " ", trim: true))
    end)
  end
end
