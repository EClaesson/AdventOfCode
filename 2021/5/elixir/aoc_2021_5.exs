defmodule AOC do
  @line ~r/(\d+),(\d+) -> (\d+),(\d+)/

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
    |> Enum.map(&Regex.run(@line, &1))
    |> Enum.map(
         fn [_ | nums] ->
           nums
           |> Enum.map(&String.to_integer/1)
         end
       )
  end

  def filter_diagonal(values) do
    values
    |> Enum.filter(fn [x1, y1, x2, y2] -> x1 == x2 or y1 == y2 end)
  end

  def coords([x1, y1, x2, y2]) when x1 == x2 or y1 == y2 do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end

  def coords([x1, y1, x2, y2]) do
    x_mult = if x1 > x2, do: -1, else: 1
    y_mult = if y1 > y2, do: -1, else: 1

    for n <- 0..(max(x1, x2) - min(x1, x2)), do: {x1 + (n * x_mult), y1 + (n * y_mult)}
  end

  def count_overlaps(coords) do
    coords
    |> Enum.frequencies
    |> Enum.filter(fn {_, count} -> count >= 2 end)
    |> Enum.count
  end

  def run_part_a(values) do
    values
    |> AOC.filter_diagonal
    |> Enum.flat_map(&AOC.coords/1)
    |> AOC.count_overlaps
  end

  def run_part_b(values) do
    values
    |> Enum.flat_map(&AOC.coords/1)
    |> AOC.count_overlaps
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
