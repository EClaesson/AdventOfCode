defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(fn line ->
      line
      |> String.trim
      |> String.split("   ")
      |> Enum.map(&String.to_integer(&1))
      |> List.to_tuple
    end)
    |> Enum.unzip
  end

  def run_a(values) do
    values
    |> Tuple.to_list
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum
  end

  def run_b(values) do
    {left, right} = values

    freq = right
    |> Enum.frequencies

    left
    |> Enum.map(fn n -> n * Map.get(freq, n, 0) end)
    |> Enum.sum
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a)
IO.inspect(AOC.read_input() |> AOC.run_b)
