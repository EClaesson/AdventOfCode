defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(
         fn line ->
           String.graphemes(line)
           |> Enum.map(&String.to_integer/1)
         end
       )
    |> Enum.to_list
  end

  def bits_to_int(bits) do
    bits
    |> Enum.join
    |> String.to_integer(2)
  end

  def get_bit_from_sum(sum, len) do
    case len / 2 do
      half when sum < half -> 0
      half when sum >= half -> 1
    end
  end

  def get_most_common_bits(values) do
    len = values
          |> length

    values
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.map(&AOC.get_bit_from_sum(&1, len))
  end

  def filter_to_one(values, _, _) when length(values) == 1 do
    values
    |> hd
  end

  def filter_to_one(values, mode, index) when length(values) > 1 do
    len = values
          |> length
    target = values
             |> Enum.map(&Enum.at(&1, index))
             |> Enum.sum
             |> AOC.get_bit_from_sum(len)
             |> then(fn bit -> if mode == :least, do: 1 - bit, else: bit end)

    remaining = values
                |> Enum.filter(
                     fn bits ->
                       bits
                       |> Enum.at(index) == target end
                   )

    AOC.filter_to_one(remaining, mode, index + 1)
  end

  def run_part_a(values) do
    common = values
             |> AOC.get_most_common_bits

    gamma = common
            |> AOC.bits_to_int

    epsilon = common
              |> Enum.map(fn bit -> 1 - bit end)
              |> AOC.bits_to_int()

    gamma * epsilon
  end

  def run_part_b(values) do
    oxygen = values
             |> AOC.filter_to_one(:most, 0)
             |> AOC.bits_to_int

    co2 = values
          |> AOC.filter_to_one(:least, 0)
          |> AOC.bits_to_int

    oxygen * co2
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
