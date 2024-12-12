# Command to run is elixir -r ../../general/parse.ex day_7.ex
defmodule Day7 do
  alias General.Parse
  @ops [:add, :mul]

  def solve(filename) do
    filename
    |> Parse.generate_grid()
    |> Parse.split_by_delimiter(":")
    |> Parse.reduce_into_map()
    # |> IO.inspect(label: "DEBUG")
    |> Enum.map(fn {res, vals} ->
      combine_to_result?({String.to_integer(res), Enum.map(vals, &String.to_integer/1)})
    end)
    |> IO.inspect(label: "DEBUG")
  end

  # def combine_vals(acc, [], _), do: acc
  # def combine_vals(acc, [i | rest], ops) do
  #   ops
  #     |> Enum.flat_map(fn op ->
  #       acc |> Enum.map(fn j ->
  #         case op do
  #           :plus -> j + i
  #           :mul -> j * i
  #           :cat -> "#{j}#{i}" |> String.to_integer()
  #         end
  #       end)
  #     end)
  #   |> combine(rest, ops)
  # end

  def combine_to_result?({res, vals}) do
    is_sum = sum_to?(res, vals)
    # is_difference = subtract_to?(res, vals)
    is_product = product?(res, vals)
    # is_quotient = quotient?(res, vals)

    groups =
      vals
      |> Enum.chunk_every(2, 1)
      |> Enum.reject(&length(&1) == 1)
      # |> IO.inspect(label: "DEBUG1", charlists: :numbers)

    recurse_sum = sum_to?(res, vals, groups)
    recurse_product = product?(res, vals, groups)


    # I need to recursively map sequential values to build up to a result

    case is_sum || is_product || recurse_sum || recurse_product do
      true -> 1
      _ -> 0
    end
  end

  def sum_to?(res, vals) do
    Enum.sum(vals) == res
  end

  def sum_to?(_res, _vals, []), do: false
  def sum_to?(res, _vals, [a]) when a == res, do: true
  def sum_to?(res, _vals, [a]) when a != res, do: false
  def sum_to?(res, _vals, [a, b]) when a + b == res, do: true
  def sum_to?(res, _vals, [a, b]) when a + b != res, do: false

  def sum_to?(res, vals, [h | t]) do
    sum_to?(res, vals, h) || sum_to?(res, vals, t) || product?(res, vals, t)
  end

  def subtract_to?(res, vals) do
    Enum.reduce(vals, &(&2 - &1)) == res
  end

  def product?(res, vals) do
    Enum.reduce(vals, &(&1 * &2)) == res
  end

  def product?(_res, _vals, []), do: false
  def product?(res, _vals, [a]) when a == res, do: true
  def product?(res, _vals, [a]) when a != res, do: false
  def product?(res, _vals, [a, b]) when a * b == res, do: true
  def product?(res, _vals, [a, b]) when a * b != res, do: false

  def product?(res, vals, [h | t]) do
    h |> IO.inspect(label: "h", charlists: :numbers)
    # Tail is coming in as array of arrays
    t |> IO.inspect(label: "t", charlists: :numbers)
    [a, b] = t |> IO.inspect(label: "DEBUG")
    product?(res, vals, h) || product?(res, vals, t) || sum_to?(res, vals, t)
  end

  def quotient?(res, vals) do
    Enum.reduce(vals, &(&2 / &1)) == res
  end
end

Day7.solve("test.txt")
