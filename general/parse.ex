defmodule Parse do
  @moduledoc """
  File and string transformation utilities
  """

  def generate_grid(filename) do
    {:ok, input} = File.read(filename)

    input
    |> String.split("\n", trim: true)
  end

  def groups_of_two(grid) do

  end
end
