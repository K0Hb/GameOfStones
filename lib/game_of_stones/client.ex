defmodule GameOfStones.Client do
  @server GameOfStones.Server

  def play(initial_stones_num) do
    GenServer.start_link(@server, {:started, initial_stones_num}, name: @server)

    {player, current_stones} = GenServer.call(@server, :current_state)

    IO.puts("Игра началась. Ход игрока: #{player}, камней в куче осталось: #{current_stones}.")

    next_turn()
  end

  defp next_turn() do
    case GenServer.call(@server, {:take, ask_stones()}) do
      {:next_turn, next_player, stones_count} ->
        IO.puts("\nХод игрока: #{next_player}. Осталось камней: #{stones_count}")
        next_turn()
      {:winner, winner} -> IO.puts("\nИгрок: #{winner} победил.")
      {:error, reason} ->
        IO.puts("\nПроизошла ошибка: #{reason}.")
        next_turn()
    end
  end

  defp ask_stones() do
    IO.puts("\n Сколько камней возьмете?")
    IO.gets("\n Введите цифру:") |>
    String.trim() |>
    Integer.parse() |>
    stones_to_take()
  end

  defp stones_to_take(:error), do: 0
  defp stones_to_take({count, _}), do: count
end
