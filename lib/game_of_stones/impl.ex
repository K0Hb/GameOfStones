defmodule GameOfStones.Impl do
  alias GameOfStones.IoTemplates

  def do_take({player, num_stones, current_stones})
  when not is_integer(num_stones) or
  num_stones < 1 or
  num_stones > 3 or
  num_stones > current_stones do
    message = IoTemplates.puts_limit_get_stones()

    {:reply, {:error, message}, {player, current_stones, :game_in_progress}}
  end

  def do_take({player, num_stones, current_stones}) when num_stones == current_stones do
    {
      :stop,
      :normal,
      {:winner, next_player(player)}, # ответ клиенту
      {nil, 0, :game_finish} # новое состояние
    }
  end

  def do_take({player, num_stones, current_stones}) do
    new_current_stones = current_stones - num_stones
    next_player = next_player(player)

    {
      :reply,
      {:next_turn, next_player, new_current_stones}, # ответ клиенту
      {next_player, new_current_stones, :game_in_porgress} # новое состояние
    }
  end

  defp next_player(1), do: 2
  defp next_player(2), do: 1
end
