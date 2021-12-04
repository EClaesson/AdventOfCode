# NOTE: This is a very inefficient and slow way of solving this.

defmodule AOC do
  def run_iteration(input, output) when input == [], do: output

  def run_iteration(input, output) do
    first = input
            |> hd
    count = input
            |> Enum.find_index(fn digit -> digit != first end)
    count = count || length(input)
    res = "#{count}#{first}"
          |> String.graphemes

    run_iteration(
      input
      |> Enum.drop(count),
      output ++ res
    )
  end

  def run_iterations(input, num) when num == 0,
      do: input
          |> Enum.join

  def run_iterations(input, num) do
    IO.inspect(num)
    input
    |> AOC.run_iteration([])
    |> AOC.run_iterations(num - 1)
  end

  def run_part_a(value) do
    AOC.run_iterations(value, 40)
    |> String.length
  end

  def run_part_b(value) do
    AOC.run_iterations(value, 50)
    |> String.length
  end
end

IO.puts("Part A: #{"1113122113" |> String.graphemes |> AOC.run_part_a}")
IO.puts("Part B: #{"1113122113" |> String.graphemes |> AOC.run_part_b}")
