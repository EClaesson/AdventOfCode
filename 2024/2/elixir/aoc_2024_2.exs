defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, " "))
    |> Stream.map(fn report ->
      Enum.map(report, &String.to_integer/1)
    end)
    |> Enum.to_list()
  end

  def is_safe?(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] ->
      cond do
        b <= a -> false
        b - a > 3 -> false
        true -> true
      end
    end)
    |> Enum.all?()
  end

  def variations(report) do
    partials =
      0..(Enum.count(report) - 1)
      |> Enum.map(fn idx ->
        report
        |> Enum.with_index()
        |> Enum.reject(fn {_, elem_idx} -> elem_idx == idx end)
        |> Enum.map(fn {val, _} -> val end)
      end)

    [report | partials]
  end

  def run_a(values) do
    values
    |> Enum.filter(fn report -> is_safe?(report) or is_safe?(Enum.reverse(report)) end)
    |> Enum.count()
  end

  def run_b(values) do
    values
    |> Enum.map(&variations/1)
    |> Enum.filter(fn reports ->
      reports
      |> Enum.any?(fn report -> is_safe?(report) or is_safe?(Enum.reverse(report)) end)
    end)
    |> Enum.count()
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a())
IO.inspect(AOC.read_input() |> AOC.run_b())
