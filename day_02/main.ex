defmodule Day2 do
  @inputfile "input.txt"
  @moves ["Rock", "Paper", "Scissors"]
  @elves_map %{"A" => "Rock", "B" => "Paper", "C" => "Scissors"}
  @part1_map %{"X" => "Rock", "Y" => "Paper", "Z" => "Scissors"}
  @part2_map %{"X" => -1, "Y" => 0, "Z" => 1}
  @points %{"Rock" => 1, "Paper" => 2, "Scissors" => 3}


  def calc_points_p1(round) do
    [elf, player] = round
    win_points = case rem(Enum.find_index(@moves,& &1 == @part1_map[player]) - Enum.find_index(@moves, & &1 == @elves_map[elf]) + 3,3) do
      0 -> 3
      1 -> 6
      2 -> 0
    end
    win_points + @points[@part1_map[player]]
  end

  def calc_points_p2(round) do
    [elf, player] = round
    {:ok, player_move} = Enum.fetch(@moves, rem(Enum.find_index(@moves, & &1 == @elves_map[elf]) + @part2_map[player] + 3,3))
    win_points = case player do
      "X" -> 0
      "Y" -> 3
      "Z" -> 6
    end
    win_points + @points[player_move]
  end

  def solve do
    {:ok, contents} = File.read(@inputfile)

    cleaned_input = contents
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.split/1)

    #part1
    cleaned_input
    |> Enum.map(&calc_points_p1/1)
    |> Enum.sum
    |> IO.puts

    #part 2
    cleaned_input
    |> Enum.map(&calc_points_p2/1)
    |> Enum.sum
    |> IO.puts
  end
end

Day2.solve()
