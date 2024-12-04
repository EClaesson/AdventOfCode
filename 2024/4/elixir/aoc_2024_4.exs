defmodule AOC do
  @target_a "XMAS"
  @length_a String.length(@target_a)

  @target_b "MAS"
  @length_b String.length(@target_b)

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, "", trim: true))
    |> Enum.to_list()
  end

  def range_to_list(range) do
    list =
      range
      |> Range.to_list()

    case length(list) do
      1 -> List.duplicate(List.first(list), @length_a)
      _ -> list
    end
  end

  def outside?(values, y_list, x_list) do
    under =
      (y_list ++ x_list)
      |> Enum.any?(fn n -> n < 0 end)

    over_y =
      y_list
      |> Enum.any?(fn y -> y >= length(values) end)

    over_x =
      x_list
      |> Enum.any?(fn x -> x > length(Enum.at(values, 0)) end)

    under or over_y or over_x
  end

  def get_str(values, y_range, x_range) do
    y_list = range_to_list(y_range)
    x_list = range_to_list(x_range)

    if outside?(values, y_list, x_list) do
      nil
    else
      y_list
      |> Enum.with_index()
      |> Enum.map(fn {y, idx} ->
        Enum.at(values, y)
        |> Enum.at(Enum.at(x_list, idx))
      end)
      |> Enum.join()
    end
  end

  def get_string_starting_at(values, y, x) do
    horizontal = [
      get_str(values, y..y, x..(x + @length_a - 1)),
      get_str(values, y..y, x..(x - @length_a + 1))
    ]

    vertical = [
      get_str(values, y..(y + @length_a - 1), x..x),
      get_str(values, y..(y - @length_a + 1), x..x)
    ]

    diagonal = [
      get_str(values, y..(y + @length_a - 1), x..(x + @length_a - 1)),
      get_str(values, y..(y + @length_a - 1), x..(x - @length_a + 1)),
      get_str(values, y..(y - @length_a + 1), x..(x + @length_a - 1)),
      get_str(values, y..(y - @length_a + 1), x..(x - @length_a + 1))
    ]

    horizontal ++ vertical ++ diagonal
  end

  def get_x_from(values, y, x) do
    part_len = trunc((@length_b - 1) / 2)

    [
      get_str(values, (y - part_len)..(y + part_len), (x - part_len)..(x + part_len)),
      get_str(values, (y - part_len)..(y + part_len), (x + part_len)..(x - part_len))
    ]
  end

  def valid_x?([a, b]) do
    a != nil and
      b != nil and
      (a == @target_b or String.reverse(a) == @target_b) and
      (b == @target_b or String.reverse(b) == @target_b)
  end

  def run_a(values) do
    rows = length(values)
    cols = length(values |> hd())
    coords = for y <- 0..(rows - 1), x <- 0..(cols - 1), do: {y, x}

    coords
    |> Enum.filter(fn {y, x} ->
      Enum.at(Enum.at(values, y), x) == "X"
    end)
    |> Enum.flat_map(fn {y, x} ->
      get_string_starting_at(values, y, x)
    end)
    |> Enum.reject(fn val -> val != @target_a end)
    |> Enum.count()
  end

  def run_b(values) do
    rows = length(values)
    cols = length(values |> hd())
    coords = for y <- 0..(rows - 1), x <- 0..(cols - 1), do: {y, x}

    coords
    |> Enum.map(fn {y, x} ->
      get_x_from(values, y, x)
      |> valid_x?()
    end)
    |> Enum.count(fn valid -> valid end)
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a())
IO.inspect(AOC.read_input() |> AOC.run_b())
