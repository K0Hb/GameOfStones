defmodule GameOfStones.Server do
  use GenServer, restart: :transient

  alias GameOfStones.Impl
  alias GameOfStones.Color

  def start_link(_args) do
    GenServer.start_link(__MODULE__, :started, name: __MODULE__)
  end

  def init(:started) do
    IO.puts Color.light_blue("Стартовал сервер GameOfStones")
    {:ok, {1, nil, :started}}
  end

  def handle_call({:set, num_stones}, _from, {player, nil, :started}) do
    Impl.do_set({player, num_stones})
  end

  def handle_call(:current_state, _from, {player, current_stones, _}) do
    {:reply, {player, current_stones}, {player, current_stones, :game_in_progress}}
  end

  def handle_call({:take, num_stones}, _from, {player, current_stones, _}) do
    Impl.do_take({player, num_stones, current_stones})
  end

  def terminate(_reason, _state) do
    IO.puts Color.green("Игра закончена.")
  end
end
