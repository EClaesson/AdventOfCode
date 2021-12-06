defmodule AOC do
  def read_input() do
    freq = File.read!("../input")
           |> String.trim
           |> String.split(",")
           |> Enum.frequencies

    0..8
    |> Enum.map(&Map.get(freq, "#{&1}", 0))
  end

  def iterate(days, num) when num == 0, do: days

  def iterate(days, num) do
    [zero | rest] = days
    new = rest ++ [zero]

    List.replace_at(new, 6, Enum.at(new, 6) + zero)
    |> AOC.iterate(num - 1)
  end

  def run_part_a(values) do
    values
    |> AOC.iterate(80)
    |> Enum.sum
  end

  def run_part_b(values) do
    values
    |> AOC.iterate(256)
    |> Enum.sum
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a()}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b()}")
