defmodule Day6 do
  @inputfile "input.txt"

  def find_distinct(stream, n) do
    stream
    |> Enum.chunk_every(n,1)
    |> Enum.take_while(fn(y) -> MapSet.size(MapSet.new(y)) < n end)
    |> length
    |> Kernel.+(n)
  end

  def solve do
    {:ok, contents} = File.read(@inputfile)
    cleaned_inputs = contents
    |> String.trim_trailing
    |> String.codepoints

    #part 1
    cleaned_inputs
    |> find_distinct(4)
    |> IO.puts

    #part2
    cleaned_inputs
    |> find_distinct(14)
    |> IO.puts
  end
end

Day6.solve()
