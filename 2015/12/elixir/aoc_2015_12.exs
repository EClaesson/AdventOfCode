defmodule AOC do
  @number ~r/-?[0-9]+/

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
    |> hd
  end

  def filter_red(obj) when is_map(obj) do
    if "red" in Map.values(obj) do
      nil
    else
      obj
      |> Map.values
      |> AOC.filter_red
    end
  end

  def filter_red(obj) when is_list(obj) do
    obj
    |> Enum.map(&AOC.filter_red/1)
  end

  def filter_red(obj) do
    obj
  end

  def run_part_a(value) do
    Regex.scan(@number, value)
    |> Enum.map(&hd/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end

  def run_part_b(values) do
    values
    |> JSON.decode!
    |> AOC.filter_red
    |> JSON.encode!
    |> AOC.run_part_a
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
