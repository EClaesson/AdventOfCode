defmodule AOC do
  def hash(num) do
    :crypto.hash(:md5, "iwrupvqb#{num}")
    |> Base.encode16()
  end

  def get_index_of_hash(start) do
    1
    |> Stream.iterate(& &1 + 1)
    |> Enum.find(
         fn num ->
           AOC.hash(num)
           |> String.starts_with?(start)
         end
       )
  end

  def run_part_a() do
    AOC.get_index_of_hash("00000")
  end

  def run_part_b() do
    AOC.get_index_of_hash("000000")
  end
end

IO.puts("Part A: #{AOC.run_part_a()}")
IO.puts("Part B: #{AOC.run_part_b()}")
