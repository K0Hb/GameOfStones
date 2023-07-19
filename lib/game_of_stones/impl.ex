defmodule GameOfStones.Impl do
  alias GameOfStones.IoTemplates
  alias GameOfStones.Color

  def do_set({player, num_stones}) when not is_integer(num_stones) or num_stones < 4 do
    {
      :strop,
      :normal,
      {:error, Color.red("Камней должно быть не менее 4шт")},
      {player, 0, :game_finish}
    }
  end

  def do_set({player, num_stones}) do
    {:reply, {:stones_set, player, num_stones}, {player, num_stones, :game_in_progress}}
  end

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
      :reply,
      {:winner, next_player(player)}, # ответ клиенту
      {player, nil, :started} # новое состояние
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
