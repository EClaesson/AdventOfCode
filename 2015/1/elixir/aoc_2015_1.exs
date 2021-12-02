defmodule AOC do
  def read_input() do
    File.read!("../input")
    |> String.trim
    |> String.graphemes
  end

  def run_part_a(values) do
    Enum.reduce(
      values,
      0,
      fn
        "(", floor -> floor + 1
        ")", floor -> floor - 1
      end
    )
  end

  def run_part_b(values) do
    Enum.with_index(values)
    |> Enum.reduce_while(
         0,
         fn
           {"(", _}, floor -> {:cont, floor + 1}
           {")", index}, 0 -> {:halt, index + 1}
           {")", _}, floor -> {:cont, floor - 1}
         end
       )
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
