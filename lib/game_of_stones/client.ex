defmodule GameOfStones.Client do
  @server GameOfStones.Server

  alias GameOfStones.IoTemplates
  alias GameOfStones.Color

  def play(initial_stones_num) do
    GenServer.start_link(@server, {:started, initial_stones_num}, name: @server)

    {player, current_stones} = GenServer.call(@server, :current_state)

    IoTemplates.puts_game_start(player, current_stones)
    next_turn()
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
  defp restart?(_), do: IO.puts Color.red("До встречи.")

  defp start do
    get_started_count_stones() |> play()
  end

  defp get_started_count_stones do
    {count_stones, _} =
      IoTemplates.gets_start_count_stones() |>
      String.trim() |>
      Integer.parse()

    cond do
      count_stones >= 3 -> count_stones
      count_stones < 3 -> get_started_count_stones()
    end
  end
end
