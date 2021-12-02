defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(
         fn line ->
           String.split(line, "x")
           |> Enum.map(&String.to_integer/1)
         end
       )
    |> Enum.to_list
  end

  def run_part_a(values) do
    Enum.map(values, fn [l, w, h] -> [2 * l * w, 2 * w * h, 2 * h * l] end)
    |> Enum.map(
         fn sides ->
           Enum.sum(sides) + Enum.min(sides) / 2
           |> trunc
         end
       )
    |> Enum.sum
  end

  def run_part_b(values) do
    Enum.map(
      values,
      fn sides ->
        Enum.sort(sides)
        |> Enum.slice(0..1)
        |> Enum.sum
        |> then(fn sum -> sum * 2 + Enum.product(sides) end) end
    )
    |> Enum.sum
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
