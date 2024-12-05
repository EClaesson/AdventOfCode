defmodule AOC do
  def read_input() do
    map =
      File.stream!("../input")
      |> Stream.map(&String.trim/1)
      |> Stream.reject(&(&1 == ""))
      |> Enum.reduce(%{"rules" => [], "updates" => []}, fn line, acc ->
        if String.contains?(line, "|") do
          parts = String.split(line, "|")
          new = Map.get(acc, "rules") ++ [parts]
          Map.put(acc, "rules", new)
        else
          parts = String.split(line, ",")
          new = Map.get(acc, "updates") ++ [parts]
          Map.put(acc, "updates", new)
        end
      end)

    {Map.get(map, "updates"), Map.get(map, "rules")}
  end

  def get_rule_values(target, rules) do
    vals_before =
      rules
      |> Enum.filter(fn [_, val] -> target == val end)
      |> Enum.map(fn [val, _] -> val end)

    vals_after =
      rules
      |> Enum.filter(fn [val, _] -> target == val end)
      |> Enum.map(fn [_, val] -> val end)

    {vals_before, vals_after}
  end

  def sort_by_rules(update, rules) do
    update
    |> Enum.sort(fn a, b ->
      {vals_before_a, _} = get_rule_values(a, rules)
      {_, vals_after_b} = get_rule_values(b, rules)

      cond do
        Enum.member?(vals_before_a, b) -> false
        Enum.member?(vals_after_b, a) -> false
        true -> true
      end
    end)
  end

  def run_a({updates, rules}) do
    updates
    |> Enum.filter(fn update ->
      update == sort_by_rules(update, rules)
    end)
    |> Enum.map(fn update ->
      idx = trunc((length(update) - 1) / 2)

      Enum.at(update, idx)
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  def run_b({updates, rules}) do
    updates
    |> Enum.map(fn update ->
      sorted = sort_by_rules(update, rules)
      {update != sorted, sorted}
    end)
    |> Enum.filter(fn {was_incorrect, _} -> was_incorrect end)
    |> Enum.map(fn {_, update} -> update end)
    |> Enum.map(fn update ->
      idx = trunc((length(update) - 1) / 2)

      Enum.at(update, idx)
      |> String.to_integer()
    end)
    |> Enum.sum()
  end
end

IO.inspect(AOC.read_input() |> AOC.run_a())
IO.inspect(AOC.read_input() |> AOC.run_b())
