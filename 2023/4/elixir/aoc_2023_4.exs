defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ~r/:|\|/))
    |> Enum.map(fn [id, winning, numbers] ->
      {
        String.to_integer(List.last(String.split(id, " "))),
        winning
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1),
        numbers
        |> String.split(" ", trim: true)
        |> Enum.map(&String.to_integer/1)
      }
    end)
    |> Enum.to_list
  end

  def run_a(values) do
    values
    |> Enum.map(fn {_, winning, numbers} ->
      matches = MapSet.size(MapSet.intersection(MapSet.new(winning), MapSet.new(numbers)))
      if matches > 0, do: 2 ** (matches - 1), else: 0
    end)
    |> Enum.sum
  end

  def scratch(cards, _, total_count) when length(cards) == 0 do
    total_count
  end

  def scratch(cards, counts, total_count) do
    [{_, winning, numbers} | remaining] = cards
    [count | remaining_counts] = counts
    wins = MapSet.size(MapSet.intersection(MapSet.new(winning), MapSet.new(numbers)))

    {mod_counts, rest_counts} = Enum.split(remaining_counts, wins)

    mod_counts = mod_counts
    |> Enum.map(fn c -> c + count end)
    new_counts = mod_counts ++ rest_counts

    scratch(remaining, new_counts, total_count + (wins * count))
  end

  def run_b(values) do
    values
    |> scratch(values |> Enum.map(fn _ -> 1 end), Enum.count(values))
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a)
IO.inspect(AOC.read_input() |> AOC.run_b)
