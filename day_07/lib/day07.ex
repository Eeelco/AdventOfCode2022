defmodule Day07 do
  import Tree

  @inputfile "input.txt"
  use Application

  # Part 1 funcs
  def p1_traverse({:file, _, _}) do
    0
  end

  def p1_traverse({:dir, size, children}) do
    s = if size <= 100000, do: size, else: 0
    s + (Enum.map(children, &p1_traverse/1) |> Enum.sum)
  end

  #Part 2 funcs

  def p2_traverse({:dir, size, children}) do
    child_dirs =  children
    |> Enum.filter(fn({t,_,_}) -> t == :dir end)
    [size | (Enum.map(child_dirs, &p2_traverse/1) |> List.flatten)]
  end
  def part2(tree) do
    {_, size, _} = tree
    missing_space = 30000000 - (70000000 - size)
    p2_traverse(tree)
    |> Enum.filter(fn(x) -> x >= missing_space end)
    |> Enum.min
  end

  def start(_type, _args) do
    {:ok, contents} = File.read(@inputfile)
    [tree, _] = contents
    |> String.trim_trailing
    |> String.split("\n")
    |> (fn(x) -> build_tree({:dir, "/", []}, List.delete_at(x,0)) end).()

    t = mapsize(tree)
    p1_traverse(t)
    |> IO.puts

    part2(t)
    |> IO.puts
  end
end
