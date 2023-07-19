defmodule GameOfStones.Client do
  @server GameOfStones.Server

  alias GameOfStones.IoTemplates
  alias GameOfStones.Color

  def main(argv) do
    parse(argv) |> set_initial_stones()
  end

  defp set_initial_stones(stones_to_set) do
    case GenServer.call(@server, {:set, stones_to_set}) do
      {:stones_set, player, num_stones} ->
        IoTemplates.puts_game_start(player, num_stones)

        next_turn()
      {:error, reason} ->
        IoTemplates.puts_error(reason)
        exit(:normal)
    end
  end

  defp parse(argv) do
    {opts, _, _} = OptionParser.parse(argv, switches: [stones: :integer])
    opts |> Keyword.get(:stones, Application.get_env(:game_of_stones, :default_stones))
  end

  defp next_turn() do
    case GenServer.call(@server, {:take, ask_stones()}) do
      {:next_turn, next_player, stones_count} ->
        IoTemplates.puts_next_turn(next_player, stones_count)
        next_turn()
      {:winner, winner} ->
        IoTemplates.puts_winner(winner)
        restart?()
      {:error, reason} ->
        IO.puts Color.red("Произошла ошибка: #{reason}")
        next_turn()
    end
  end

  defp ask_stones() do
    IoTemplates.gets_get_stones() |>
    String.trim() |>
    Integer.parse() |>
    stones_to_take()
  end

  defp stones_to_take(:error), do: 0
  defp stones_to_take({count, _}), do: count

  def restart?() do
    IoTemplates.gets_restart() |>
    String.trim() |>
    Integer.parse() |>
    restart?()
  end

  defp restart?({num, _}) when num == 1,  do: start()
  defp restart?(_) do
    IO.puts Color.red("До встречи.")
    exit(:normal)
  end

  defp start do
    get_started_count_stones() |> set_initial_stones()
  end

  defp get_started_count_stones do
    {count_stones, _} =
      IoTemplates.gets_start_count_stones() |>
      String.trim() |>
      Integer.parse()

    cond do
      count_stones >= 4 -> count_stones
      count_stones < 4 -> get_started_count_stones()
    end
  end
end
