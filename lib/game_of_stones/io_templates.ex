defmodule GameOfStones.IoTemplates do

  alias GameOfStones.Color

  def puts_game_start(player, current_stones) do
    IO.puts(
      Color.purple("Игра началась. Ход игрока: ") <>
      Color.int_green(player) <>
      Color.purple(", камней в куче осталось: ") <>
      Color.int_green(current_stones)
    )
  end

  def puts_next_turn(next_player, current_stones) do
    IO.puts(
      Color.purple("Ход игрока: ") <>
      Color.int_green(next_player) <>
      Color.purple(".Осталось камней: ") <>
      Color.int_green(current_stones)
    )
  end

  def puts_winner(winner) do
    IO.puts(
      Color.blue("Игрок: ") <>
      Color.int_green(winner) <>
      Color.blue(", победил!")
    )
  end

  def gets_get_stones do
    IO.gets(Color.blue("Сколько камней возьмете?\nВведите цифру:"))
  end

  def gets_restart do
    IO.gets(
      Color.light_blue("Желаете начать игру заново?\nВведите цифру(") <>
      Color.green("0") <>
      Color.light_blue(" - нет, ") <>
      Color.green("1") <>
      Color.light_blue(" - да):")
    )
  end

  def gets_start_count_stones do
    IO.gets(
      Color.light_blue("Какое количество камней будет в куче?") <>
      Color.light_blue("\nКоличество камней, должно быть не менее:") <>
      Color.green(" 4") <>
      Color.light_blue("\nВведите цифру:")
    )
  end

  def puts_limit_get_stones do
    Color.red("Вы можете взять от ") <>
    Color.green("1") <>
    Color.red(" до ") <>
    Color.green("3") <>
    Color.red(" камней.")
  end

  def puts_error(reason) do
    IO.gets(
      Color.red("Произошла ошибка:") <>
      Color.blue(reason)
    )
  end
end
