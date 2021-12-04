defmodule AOC do
  def read_input() do
    File.stream!("../input")
    |> Stream.map(&String.trim/1)
    |> Stream.reject(fn line -> line == "" end)
    |> Enum.to_list
    |> then(
         fn lines ->
           {
             lines
             |> hd
             |> String.split(",")
             |> Enum.map(&String.to_integer/1),
             lines
             |> tl
             |> Enum.map(&String.split/1)
             |> Enum.chunk_every(5)
             |> Enum.map(&AOC.init_board/1)
           }
         end
       )
  end

  def init_board(rows) do
    rows
    |> Enum.map(
         fn row ->
           row
           |> Enum.map(fn col -> {String.to_integer(col), false} end)
         end
       )
  end

  def mark(board, called) do
    board
    |> Enum.map(
         fn row ->
           row
           |> Enum.map(fn {num, marked} -> {num, marked || num == called} end)
         end
       )
  end

  def mark_all(boards, called) do
    boards
    |> Enum.map(&mark(&1, called))
  end

  def mark_all_b(boards, called) do
    boards
    |> Enum.map(fn {board, won} -> {AOC.mark(board, called), won} end)
  end

  def all_marked?(cells) do
    cells
    |> Enum.all?(fn {_, marked} -> marked end)
  end

  def horizontal_win?(board) do
    board
    |> Enum.any?(&AOC.all_marked?/1)
  end

  def vertical_win?(board) do
    board
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.any?(&AOC.all_marked?/1)
  end

  def find_winner(boards) do
    boards
    |> Enum.find(fn board -> AOC.horizontal_win?(board) || AOC.vertical_win?(board) end)
    |> then(fn winner -> {boards, winner} end)
  end

  def find_new_winners(boards) do
    new = boards
          |> Enum.filter(fn {_, won} -> !won end)
          |> Enum.filter(fn {board, _} -> AOC.horizontal_win?(board) || AOC.vertical_win?(board) end)
          |> Enum.map(fn {board, _} -> {board, true} end)

    all = boards
          |> Enum.map(fn {board, won} -> {board, won || AOC.horizontal_win?(board) || AOC.vertical_win?(board)} end)

    {all, new}
  end

  def sum_unmarked(board) do
    board
    |> List.flatten
    |> Enum.map(
         fn
           {_, true} -> 0
           {num, false} -> num
         end
       )
    |> Enum.sum
  end

  def run_part_a(values) do
    {numbers, empty_boards} = values

    {winning_board, last_called} = numbers
                                   |> Enum.reduce_while(
                                        empty_boards,
                                        fn called, boards ->
                                          AOC.mark_all(boards, called)
                                          |> AOC.find_winner
                                          |> then(
                                               fn {marked, winner} ->
                                                 if winner, do: {:halt, {winner, called}}, else: {:cont, marked}
                                               end
                                             )
                                        end
                                      )

    winning_board
    |> AOC.sum_unmarked
    |> then(fn sum -> sum * last_called end)
  end

  def run_part_b(values) do
    {numbers, empty_boards} = values

    empty_boards = empty_boards
                   |> Enum.map(fn board -> {board, false} end)

    numbers
    |> Enum.reduce_while(
         {empty_boards, [], nil},
         fn called, {boards, winners, last_called} ->
           if length(boards) == length(winners) do
             {
               :halt,
               winners
               |> List.last
               |> then(fn {winner, _} -> AOC.sum_unmarked(winner) * last_called end)
             }
           else
             boards
             |> AOC.mark_all_b(called)
             |> AOC.find_new_winners
             |> then(
                  fn {marked, new} ->
                    {:cont, {marked, winners ++ new, called}}
                  end
                )
           end
         end
       )
  end
end

IO.puts("Part A: #{AOC.read_input() |> AOC.run_part_a}")
IO.puts("Part B: #{AOC.read_input() |> AOC.run_part_b}")
