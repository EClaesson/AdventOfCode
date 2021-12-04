defmodule AOC do
  @line ~r/^(\S+) would (\S+) (\d+) .+ (\S+)\./

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
    |> Enum.map(&Regex.run(@line, &1))
    |> Enum.map(fn [_, a, change, val, b] -> [a, b, String.to_integer(val) * %{"gain" => 1, "lose" => -1}[change]] end)
  end

  # https://elixirforum.com/t/most-elegant-way-to-generate-all-permutations/2706/2
  def permutations([]), do: [[]]
  def permutations(list), do: for elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest]

  def get_val(values, a, b) do
    values
    |> Enum.find(
         fn
           [^a, ^b, _] -> true
           _ -> false
         end
       )
    |> List.last
  end

  def calc_score(order, values) do
    order
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(
         0,
         fn [a, b], tot ->
           tot + AOC.get_val(values, a, b) + AOC.get_val(values, b, a)
         end
       )
  end

  def get_names(values) do
    values
    |> Enum.map(&hd/1)
    |> Enum.uniq
  end

  def run_part_a(values) do
    values
    |> AOC.get_names
    |> AOC.permutations
    |> Enum.map(
         fn order ->
           order ++ [
             order
             |> hd
           ]
         end
       )
    |> Enum.map(&AOC.calc_score(&1, values))
    |> Enum.max
  end

  def run_part_b(values) do
    names = values
            |> AOC.get_names

    neutral_a = names
                |> Enum.map(fn name -> ["_", name, 0] end)

    neutral_b = names
                |> Enum.map(fn name -> [name, "_", 0] end)

    values ++ neutral_a ++ neutral_b
    |> AOC.run_part_a
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
