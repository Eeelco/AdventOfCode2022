defmodule Day1 do
  @inputfile "input"

  def solve do
    {:ok, contents} = File.read(@inputfile)

    cleaned_input = contents
    |> String.split("\n")
    |> Enum.chunk_by(fn(x) -> x != "" end)
    |> Enum.reject(fn(x) -> x == [""] end)
    |> Enum.map(fn(x) -> x|>Enum.map(&String.to_integer/1) |> Enum.sum end)
    |> Enum.sort

    # Part 1
    cleaned_input
    |> List.last
    |> IO.puts

    # Part 2
    cleaned_input
    |> Enum.take(-3)
    |> Enum.sum
    |> IO.puts
  end

end

Day1.solve()
