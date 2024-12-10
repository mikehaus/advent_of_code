# Command to run is elixir -r ../../general/parse.ex day_7.ex
defmodule Day7 do
  alias General.Parse

  def solve(filename) do
    filename
    |> Parse.generate_grid()
    |> Parse.split_by_delimiter(":")
    |> Parse.reduce_into_map()
    |> IO.inspect(label: "DEBUG")
  end
end

Day7.solve("test.txt")
