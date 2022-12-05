defmodule Day5 do
  @inputfile "input.txt"

  def parse_stacks(input_list, data_stacks) do
    [head | rest] = input_list
    stack_re = ~r/\[[A-Z]\] ?|    ?/
    if String.match?(head,~r/ +\d +/) do
      [_ | tail] = rest
      [tail, data_stacks]
    else
      new_stacks = Enum.zip(Regex.scan(stack_re, head) |> Enum.map(&(List.first(&1) |> String.trim)), data_stacks)
      |> Enum.map(fn({elem, stack}) ->
        cond do
          String.length(elem) == 0 -> stack
          true -> stack ++ [elem]
        end
      end)
      parse_stacks(rest, new_stacks)
    end
  end

  def move_p1(0, _, _, stacks) do
    stacks
  end
  def move_p1(n, from, to, stacks) do
    [elem | tail] = Enum.at(stacks, from-1)
    new_stacks = List.replace_at(stacks, from-1, tail)
    |> List.replace_at(to-1, [elem | Enum.at(stacks, to-1)])
    move_p1(n-1, from, to, new_stacks)
  end

  def move_p2(n, from, to, stacks) do
    {to_move, rest} = Enum.split(Enum.at(stacks, from-1), n)
    List.replace_at(stacks, from-1, rest)
    |> List.replace_at(to-1, to_move ++ Enum.at(stacks, to-1))
  end

  def perform_moves([], final_stacks,_) do
    final_stacks
  end
  def perform_moves([op | rest], stacks, move_func) do
    [_ | numbers] = Regex.run(~r/move (\d+) from (\d) to (\d)/,op)
    [count, from, to] = numbers |> Enum.map(&String.to_integer/1)
    new_stacks = move_func.(count, from, to, stacks)
    perform_moves(rest, new_stacks, move_func)
  end

  def solve do
    {:ok, contents} = File.read(@inputfile)
    cleaned_inputs = contents
    |> String.trim_trailing
    |> String.split("\n")

    nr_stacks = ((List.first(cleaned_inputs) |> String.length) + 1) / 4 |> trunc
    stacks = for _ <- 1..nr_stacks, do: []

    [input_ops, initial_stacks] = parse_stacks(cleaned_inputs, stacks)

    #part 1
    final_stacks = perform_moves(input_ops, initial_stacks, &move_p1/4)
    final_stacks
    |> Enum.map(fn(x) -> Enum.at(x,0) end)
    |> IO.inspect

    #part2
    p2_stacks = perform_moves(input_ops, initial_stacks, &move_p2/4)
    p2_stacks
    |> Enum.map(fn(x) -> Enum.at(x,0) end)
    |> IO.inspect
  end
end

Day5.solve()
