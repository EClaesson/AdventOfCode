# NOTE: This is a very inefficient and slow way of solving this.

defmodule AOC do
  @command ~r/(.+) (\d+),(\d+) through (\d+),(\d+)/

  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list
    |> Enum.map(
         &Regex.run(@command, &1)
          |> tl
       )
    |> Enum.map(
         fn parts ->
           [
             parts
             |> hd | parts
                     |> tl
                     |> Enum.map(&String.to_integer/1)
           ]
         end
       )
  end

  def make_grid() do
    0..999
    |> Enum.map(
         fn _ ->
           0..999
           |> Enum.map(fn _ -> 0 end)
         end
       )
  end

  def grid_map(grid, fun) do
    grid
    |> Enum.with_index
    |> Enum.map(
         fn {row, y} ->
           row
           |> Enum.with_index
           |> Enum.map(
                fn {current, x} ->
                  fun.(x, y, current)
                end
              )
         end
       )
  end

  def set(grid, ax, ay, bx, by, val) do
    grid
    |> AOC.grid_map(fn x, y, current -> if x >= ax and x <= bx and y >= ay and y <= by, do: val, else: current end)
  end

  def toggle(grid, ax, ay, bx, by) do
    grid
    |> AOC.grid_map(fn x, y, current -> if x >= ax and x <= bx and y >= ay and y <= by, do: 1 - current, else: current end)
  end

  def change(grid, ax, ay, bx, by, delta) do
    grid
    |> AOC.grid_map(fn x, y, current -> if x >= ax and x <= bx and y >= ay and y <= by, do: max(0, current + delta), else: current end)
  end

  def sum_grid(grid) do
    grid
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum
  end

  def run_part_a(values) do
    values
    |> Enum.reduce(
         AOC.make_grid(),
         fn
           ["turn on", ax, ay, bx, by], grid -> AOC.set(grid, ax, ay, bx, by, 1)
           ["turn off", ax, ay, bx, by], grid -> AOC.set(grid, ax, ay, bx, by, 0)
           ["toggle", ax, ay, bx, by], grid -> AOC.toggle(grid, ax, ay, bx, by)
         end
       )
    |> AOC.sum_grid
  end

  def run_part_b(values) do
    values
    |> Enum.reduce(
         AOC.make_grid(),
         fn
           ["turn on", ax, ay, bx, by], grid -> AOC.change(grid, ax, ay, bx, by, 1)
           ["turn off", ax, ay, bx, by], grid -> AOC.change(grid, ax, ay, bx, by, -1)
           ["toggle", ax, ay, bx, by], grid -> AOC.change(grid, ax, ay, bx, by, 2)
         end
       )
    |> AOC.sum_grid
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
