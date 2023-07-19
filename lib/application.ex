defmodule GameOfStones.Application do
  use Application

  def start(_start_type, _start_args) do
    children = [GameOfStones.Server]
    options = [strategy: :one_for_one, name: GameOfStones.Supervisor]

    Supervisor.start_link(children, options)
  end
end
