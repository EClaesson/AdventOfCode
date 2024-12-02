defmodule AOC do
  @digits %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
  end

  def run_a(values) do
    values
    |> Enum.map(&String.replace(&1, ~r/\D/, ""))
    |> Enum.map(fn str -> String.to_integer(String.first(str) <> String.last(str)) end)
    |> Enum.sum
  end

  def find_digits(str, digits, offset, pattern) do
    match = Regex.run(pattern, str, return: :index, offset: offset)

    case match do
      nil -> digits
      [{idx, len}] -> find_digits(str, digits ++ [String.slice(str, idx, len)], idx + 1, pattern)
    end
  end

  def run_b(values) do
    {_, pattern} = Regex.compile(~S"\d|" <> Enum.join(Map.keys(@digits), "|"))

    values
    |> Enum.map(fn str ->
      str
      |> find_digits([], 0, pattern)
      |> Enum.map(&Map.get(@digits, &1, &1))
      |> Enum.join("")
    end)
    |> run_a
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a)
IO.inspect(AOC.read_input() |> AOC.run_b)
