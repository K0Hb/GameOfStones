defmodule GameOfStones.Color do
  def green(string) do
    IO.ANSI.green() <> string <> IO.ANSI.reset()
  end

  def red(string) do
    IO.ANSI.red() <> string <> IO.ANSI.reset()
  end

  def purple(string) do
    IO.ANSI.magenta <> string <> IO.ANSI.reset()
  end

  def blue(string) do
    IO.ANSI.blue <> string <> IO.ANSI.reset()
  end

  def light_blue(string) do
    IO.ANSI.light_blue <> string <> IO.ANSI.reset()
  end

  def int_green(integer) do
    IO.ANSI.green() <> Integer.to_string(integer) <> IO.ANSI.reset()
  end

  def int_yellow(integer) do
    IO.ANSI.yellow() <> Integer.to_string(integer) <> IO.ANSI.reset()
  end
end
