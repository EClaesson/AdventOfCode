defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.replace(&1, "to ", ""))
    |> Stream.map(&String.replace(&1, "= ", ""))
    |> Stream.map(&String.split/1)
    |> Stream.map(fn [from, to, dist] -> {from, to, String.to_integer(dist)} end)
    |> Enum.to_list
  end

  # https://elixirforum.com/t/most-elegant-way-to-generate-all-permutations/2706/2
  def permutations([]), do: [[]]
  def permutations(list), do: for elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest]

  def get_locations(values) do
    values
    |> Enum.map(fn {from, to, _} -> [from, to] end)
    |> List.flatten
    |> Enum.uniq
  end

  def get_paths(values, locations) do
    init = locations
           |> Enum.reduce(%{}, fn location, res -> Map.put(res, location, %{}) end)

    distances = values
                |> Enum.reduce(
                     init,
                     fn {from, to, dist}, res ->
                       Map.replace(
                         Map.replace(res, from, Map.put(res[from], to, dist)),
                         to,
                         Map.put(res[to], from, dist)
                       )
                     end
                   )

    AOC.permutations(locations)
    |> Enum.map(
         fn path ->
           {dist, _} = path
                       |> Enum.reduce(
                            {0, nil},
                            fn
                              loc, {_, nil} -> {0, loc}
                              loc, {tot, last} -> {tot + distances[loc][last], loc}
                            end
                          )

           {dist, locations}
         end
       )
  end

  def run_part_a(values) do
    locations = values
                |> AOC.get_locations
    paths = values
            |> AOC.get_paths(locations)

    paths
    |> Enum.reduce(
         99999,
         fn
           {dist, _}, min when dist < min -> dist
           _, min -> min
         end
       )
  end

  def run_part_b(values) do
    locations = values
                |> AOC.get_locations
    paths = values
            |> AOC.get_paths(locations)

    paths
    |> Enum.reduce(
         0,
         fn
           {dist, _}, max when dist > max -> dist
           _, max -> max
         end
       )
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
