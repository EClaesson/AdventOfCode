defmodule AOC do
  @escape ~r/(\\\\)|(\\\")|(\\x[a-f0-9]{2})/

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
    |> Enum.reject(fn line -> line == "" end)
  end

  def run_part_a(values) do
    code_len = values
               |> Enum.map(&String.length/1)
               |> Enum.sum

    char_len = values
               |> Enum.map(&Regex.replace(@escape, &1, "."))
               |> Enum.map(&String.length/1)
               |> Enum.sum
               |> then(fn sum -> sum - length(values) * 2 end)

    code_len - char_len
  end

  def run_part_b(values) do
    code_len = values
               |> Enum.map(&String.length/1)
               |> Enum.sum

    new_len = values
              |> Enum.map(&String.slice(&1, 1..-2))
              |> Enum.map(&String.replace(&1, "\\", "\\\\"))
              |> Enum.map(&String.replace(&1, "\"", "\\\""))
              |> Enum.map(fn str -> "\"\\\"" <> str <> "\\\"\"" end)
              |> Enum.map(&String.length/1)
              |> Enum.sum

    new_len - code_len
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
