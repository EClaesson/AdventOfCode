defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.replace(&1, "-> ", ""))
    |> Stream.map(&String.split/1)
    |> Enum.to_list
    |> Enum.map(
         &Enum.map(
           &1,
           fn part ->
             case Integer.parse(part) do
               {num, _} -> num
               :error -> part
             end
           end
         )
       )

  end

  def get(_, val) when is_number(val), do: val

  def get(wires, val), do: Map.get(wires, val)

  def handle(wires, unsolvable, current, a, b, fun) do
    val = AOC.get(wires, a)

    if !!val do
      {Map.put(wires, b, fun.(val)), unsolvable}
    else
      {wires, unsolvable ++ [current]}
    end
  end

  def handle(wires, unsolvable, current, a, b, c, fun) do
    val_a = AOC.get(wires, a)
    val_b = AOC.get(wires, b)

    if !!val_a and !!val_b do
      {Map.put(wires, c, fun.(val_a, val_b)), unsolvable}
    else
      {wires, unsolvable ++ [current]}
    end
  end

  def run_iteration(instructions, wires) when length(instructions) == 0, do: wires

  def run_iteration(instructions, wires) do
    instructions
    |> Enum.reduce(
         {wires, []},
         fn current, {wires, unsolvable} ->
           case current do
             [a, b] ->
               AOC.handle(wires, unsolvable, current, a, b, fn val -> val end)
             ["NOT", a, b] ->
               AOC.handle(wires, unsolvable, current, a, b, fn val -> Bitwise.bnot(val) end)
             [a, "LSHIFT", shift, b] ->
               AOC.handle(wires, unsolvable, current, a, b, fn val -> Bitwise.bsl(val, shift) end)
             [a, "RSHIFT", shift, b] ->
               AOC.handle(wires, unsolvable, current, a, b, fn val -> Bitwise.bsr(val, shift) end)
             [a, "AND", b, c] ->
               AOC.handle(wires, unsolvable, current, a, b, c, fn val_a, val_b -> Bitwise.band(val_a, val_b) end)
             [a, "OR", b, c] ->
               AOC.handle(wires, unsolvable, current, a, b, c, fn val_a, val_b -> Bitwise.bor(val_a, val_b) end)
           end
         end
       )
    |> then(fn {wires, unsolved} -> run_iteration(unsolved, wires) end)
  end

  def run_part_a(values) do
    values
    |> AOC.run_iteration(%{})
    |> then(fn wires -> wires["a"] end)
  end

  def run_part_b(values) do
    b = values
        |> AOC.run_part_a

    (
      [[b, "b"]] ++ Enum.reject(
        values,
        fn parts ->
          parts
          |> hd
          |> is_number && parts
                          |> List.last == "b" end
      ))
    |> AOC.run_part_a
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
