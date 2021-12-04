# NOTE: This is a very inefficient and slow way of solving this.

defmodule AOC do
  @forbidden [?i, ?o, ?l]
  @pairs ~r/(.)\1.*(.)\2/

  def matches_increasing?(password) do
    password
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(fn [a, b, c] -> a == b - 1 and b == c - 1 end)
  end

  def matches_allowed?(password) do
    @forbidden
    |> Enum.any?(fn c -> c in password end)
    |> Kernel.!
  end

  def matches_pairs?(password) do
    Regex.match?(
      @pairs,
      password
      |> List.to_string
    )
  end

  def ok?(password) do
    AOC.matches_increasing?(password) and AOC.matches_allowed?(password) and AOC.matches_pairs?(password)
  end

  def next(password) do
    new = password
          |> Enum.reverse
          |> Enum.map_reduce(
               true,
               fn
                 ?z, true -> {?a, true}
                 char, true -> {char + 1, false}
                 char, false -> {char, false}
               end
             )
          |> then(fn {chars, _} -> chars end)
          |> Enum.reverse

    if ok?(new), do: new, else: AOC.next(new)
  end

  def run_part_a(value) do
    value
    |> AOC.next
  end

  def run_part_b(value) do
    value
    |> AOC.next
    |> AOC.next
  end
end

IO.puts("Part A: #{"vzbxkghb" |> String.to_charlist |> AOC.run_part_a}")
IO.puts("Part B: #{"vzbxkghb" |> String.to_charlist |> AOC.run_part_b}")
