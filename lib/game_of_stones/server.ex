defmodule GameOfStones.Server do
  use GenServer

  alias GameOfStones.Impl

  def init({:started, stones_num}) do
    {:ok, {1, stones_num, :started}}
  end

  def handle_call(:current_state, _from, {player, current_stones, _}) do
    {:reply, {player, current_stones}, {player, current_stones, :game_in_progress}}
  end

  def handle_call({:take, num_stones}, _from, {player, current_stones, _}) do
    Impl.do_take({player, num_stones, current_stones})
  end

  def terminate(_reason, _state) do
    IO.puts("Игра закончена.")
  end
end
