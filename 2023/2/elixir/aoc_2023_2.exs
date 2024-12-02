defmodule AOC do
  def parse_hand(str) do
    map = str
    |> String.split(",")
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(&Enum.reverse(&1))
    |> Enum.map(&List.to_tuple/1)
    |> Map.new

    [Map.get(map, "red", "0"), Map.get(map, "green", "0"), Map.get(map, "blue", "0")]
    |> Enum.map(&String.to_integer/1)
  end

  def hands_max(hands) do
    hands
    |> Enum.reduce([0, 0, 0], fn [r, g, b], [ar, ag, ab] ->
      [max(r, ar), max(g, ag), max(b, ab)]
    end)
  end

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.slice(&1, 5..-1//1))
    |> Stream.map(&String.split(&1, ~r/:|;/))
    |> Enum.map(fn [id | hands] ->
       [id |> String.to_integer, hands |> Enum.map(&parse_hand(&1))]
    end)
  end

  def run_a(values) do
    values
    |> Enum.map(fn [id, hands] -> [id, hands |> hands_max] end)
    |> Enum.filter(fn [_, [r, g, b]] ->
      r <= 12 and g <= 13 and b <= 14
    end)
    |> Enum.map(&List.first/1)
    |> Enum.sum
  end

  def run_b(values) do
    values
    |> Enum.map(fn [id, hands] -> [id, hands |> hands_max] end)
    |> Enum.map(fn [_, [r, g, b]] -> r * g * b end)
    |> Enum.sum
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a)
IO.inspect(AOC.read_input() |> AOC.run_b)
