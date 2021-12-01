defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(fn (line) -> line |> Integer.parse |> elem(0) end)
    |> Enum.to_list
  end

  def run_part_a(values) do
    1..(length(values) - 1)
    |> Enum.filter(fn index -> Enum.at(values, index) > Enum.at(values, index - 1) end)
    |> length
  end

  def run_part_b(values) do
    Enum.chunk_every(values, 3, 1, :discard)
    |> Enum.map(fn chunk -> chunk |> Enum.sum end)
    |> run_part_a
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
