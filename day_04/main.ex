defmodule Day4 do
  @inputfile "input.txt"

  def part1(input) do
    input
    |> Enum.filter(fn([[x1,y1],[x2,y2]]) -> (x2 <= x1 && y2 >= y1) || (x2 >= x1 && y2 <= y1) end)
    |> length
  end

  def part2(input) do
    input
    |> Enum.filter(fn([[x1,y1],[x2,y2]]) -> (y1 >= x2 && x1 <= x2) || (y2 >= x1 && x2 <= x1) end)
    |> length
  end

  def solve do
    {:ok, contents} = File.read(@inputfile)

    cleaned_input = contents
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn(x) -> String.split(x,",") |> Enum.map(fn(y) -> String.split(y,"-") |> Enum.map(&String.to_integer/1) end) end)

    # part1
    part1(cleaned_input)
    |> IO.puts

    # part2
    part2(cleaned_input)
    |> IO.puts
  end
end

Day4.solve()
