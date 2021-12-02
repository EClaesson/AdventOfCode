defmodule AOC do
  def read_input() do
    File.read!("../input")
    |> String.trim
    |> String.graphemes
  end

  def get_coords(values) do
    Enum.reduce(
      values,
      {0, 0, [{0, 0}]},
      fn
        "<", {x, y, coords} -> {x - 1, y, coords ++ [{x - 1, y}]}
        ">", {x, y, coords} -> {x + 1, y, coords ++ [{x + 1, y}]}
        "^", {x, y, coords} -> {x, y - 1, coords ++ [{x, y - 1}]}
        "v", {x, y, coords} -> {x, y + 1, coords ++ [{x, y + 1}]}
      end
    )
    |> elem(2)
  end

  def run_part_a(values) do
    AOC.get_coords(values)
    |> Enum.uniq
    |> length
  end

  def run_part_b(values) do
    (
      values
      |> Enum.take_every(2)
      |> get_coords) ++ (
      values
      |> tl
      |> Enum.take_every(2)
      |> get_coords)
    |> Enum.uniq
    |> length
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
