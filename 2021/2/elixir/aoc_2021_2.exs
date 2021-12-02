defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line -> String.split(line, " ") end)
    |> Stream.map(fn [command, steps] -> {command, String.to_integer(steps)} end)
    |> Enum.to_list
  end

  def run_part_a(values) do
    Enum.reduce(
      values,
      {0, 0},
        fn
          {"forward", steps}, {horizontal, depth} -> {horizontal + steps, depth}
          {"up", steps}, {horizontal, depth} -> {horizontal, depth - steps}
          {"down", steps}, {horizontal, depth} -> {horizontal, depth + steps}
        end
    )
    |> then(fn {horizontal, depth} -> horizontal * depth end)
  end

  def run_part_b(values) do
    Enum.reduce(
      values,
      {0, 0, 0},
      fn
        {"forward", steps}, {horizontal, depth, aim} -> {horizontal + steps, depth + aim * steps, aim}
        {"up", steps}, {horizontal, depth, aim} -> {horizontal, depth, aim - steps}
        {"down", steps}, {horizontal, depth, aim} -> {horizontal, depth, aim + steps}
      end
    )
    |> then(fn {horizontal, depth, _} -> horizontal * depth end)
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
