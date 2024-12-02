defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
  end

  def find_symbols(lines, pattern) do
      lines
      |> Enum.with_index
      |> Enum.flat_map(fn {line, line_idx} ->
        Regex.scan(pattern, line, return: :index)
        |> Enum.map(&List.first/1)
        |> Enum.map(fn {idx, _} -> {line_idx, idx} end)
      end)
  end

  def surrounding_coords({idx, len}, line_idx) do
    (line_idx - 1)..(line_idx + 1)
    |> Enum.flat_map(fn y ->
      (idx - 1)..(idx + len)
      |> Enum.map(fn x ->
        {y, x}
      end)
    end)
  end

  def run_a(values) do
    sym_coords = values
                 |> find_symbols(~r/[^\d\.]/)

    values
    |> Enum.with_index
    |> Enum.flat_map(fn {line, line_idx} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> Enum.map(&List.first/1)
      |> Enum.map(fn {idx, len} ->
        {String.slice(line, idx, len), {idx, len}}
      end)
      |> Enum.map(fn {str, m} -> {str, surrounding_coords(m, line_idx)} end)
      |> Enum.filter(fn {_, coords} ->
        MapSet.size(MapSet.intersection(MapSet.new(coords), MapSet.new(sym_coords))) > 0
      end)
      |> Enum.map(fn {str, _} -> String.to_integer(str) end)
    end)
    |> Enum.sum
  end

  def run_b(values) do
    asterisk_coords = values
                  |> find_symbols(~r/\*/)

    number_coords = values
    |> Enum.with_index
    |> Enum.flat_map(fn {line, line_idx} ->
      Regex.scan(~r/\d+/, line, return: :index)
      |> Enum.map(&List.first/1)
      |> Enum.map(fn {idx, len} ->
        {String.to_integer(String.slice(line, idx, len)), {idx, len}}
      end)
      |> Enum.map(fn {str, m} -> {str, surrounding_coords(m, line_idx)} end)
    end)

    asterisk_coords
    |> Enum.map(fn coord ->
      Enum.reduce(number_coords, [], fn {number, coords}, acc ->
        count = MapSet.size(MapSet.intersection(MapSet.new([coord]), MapSet.new(coords)))

        if count > 0, do: acc ++ [number], else: acc
      end)
    end)
    |> Enum.filter(fn numbers -> Enum.count(numbers) == 2 end)
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a)
IO.inspect(AOC.read_input() |> AOC.run_b)
