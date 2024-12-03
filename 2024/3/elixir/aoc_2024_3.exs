defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.join()
  end

  def run_a(values) do
    Regex.scan(~r"mul\((\d{1,3}),(\d{1,3})\)", values)
    |> Enum.map(fn [_, a, b] ->
      String.to_integer(a) * String.to_integer(b)
    end)
    |> Enum.sum()
  end

  def mul(values) do
    [a, b] = values
    String.to_integer(a) * String.to_integer(b)
  end

  def run_b(values) do
    {res, _} =
      Regex.scan(~r"(?>mul\((\d{1,3}),(\d{1,3})\))|(?>do\(\))|(?>don't\(\))", values)
      |> Enum.reduce({0, true}, fn instruction, acc ->
        {prev, enabled} = acc
        [operation | params] = instruction

        case operation do
          "do()" -> {prev, true}
          "don't()" -> {prev, false}
          _ -> if enabled, do: {prev + mul(params), true}, else: acc
        end
      end)

    res
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a())
IO.inspect(AOC.read_input() |> AOC.run_b())
