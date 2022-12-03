defmodule Day3 do
  @inputfile "input.txt"

  def get_intersection(item) do
    Enum.reduce(item, &MapSet.intersection/2)
    |> MapSet.to_list
    |> List.first
  end

  def get_value(object) do
    ord = object |> String.to_charlist |> hd
    if String.upcase(object) == object do
      27 + ord - 65
    else
      ord - 96
    end
  end

  def solve do
    {:ok, contents} = File.read(@inputfile)

    cleaned_input = contents
    |> String.trim
    |> String.split("\n")

    # part 1
    cleaned_input
    |> Enum.map(fn (x) -> String.split_at(x,div(String.length(x),2)) |> Tuple.to_list
                          |> Enum.map(fn (y) -> MapSet.new(String.split(y,"", trim: true)) end)
                end)
    |> Enum.map(fn(x) -> get_intersection(x) |> get_value end)
    |> Enum.sum
    |> IO.puts

    #part 2
    cleaned_input
    |> Enum.map(fn (y) -> MapSet.new(String.split(y,"", trim: true)) end)
    |> Enum.chunk_every(3)
    |> Enum.map(fn(item) -> get_intersection(item) |> get_value end)
    |> Enum.sum
    |> IO.puts
  end

end

Day3.solve()
