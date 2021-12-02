defmodule AOC do
  @vowels ~r/(a|e|i|o|u)/
  @repeat ~r/(.)\1/
  @forbidden ~r/(ab|cd|pq|xy)/

  @paired_repeat ~r/(.)(.).*\1\2/
  @spaced_repeat ~r/(.).\1/

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
  end

  def run_part_a(values) do
    values
    |> Enum.filter(
         fn word ->
           Regex.scan(@vowels, word)
           |> Enum.count >= 3
         end
       )
    |> Enum.filter(
         fn word ->
           Regex.scan(@repeat, word)
           |> Enum.count > 0
         end
       )
    |> Enum.reject(
         fn word ->
           Regex.scan(@forbidden, word)
           |> Enum.count > 0
         end
       )
    |> length
  end

  def run_part_b(values) do
    values
    |> Enum.filter(
         fn word ->
           Regex.scan(@paired_repeat, word)
           |> Enum.count > 0 end
       )
    |> Enum.filter(
         fn word ->
           Regex.scan(@spaced_repeat, word)
           |> Enum.count > 0 end
       )
    |> length
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
