defmodule Parallel do
  @moduledoc """
  elixir -r WorkingWithMultipleProcesses7.exs -e "Parallel.pmap 1..10, &(&1*&1) |> inspect() |> IO.puts()"
  elixir -r WorkingWithMultipleProcesses7.exs -e "Parallel.pmap_wrong 1..10, &(&1*&1) |> inspect() |> IO.puts()"

  ^pidを_pidとすると、結果の順番がランダムになってしまう。
  """

  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
        spawn_link fn -> (send me, {self(), fun.(elem)}) end
       end)
    |> Enum.map(fn (pid) ->
        receive do {pid, result} -> result end
       end)
  end

  def pmap_wrong(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) ->
        spawn_link fn ->
          :timer.sleep(Enum.random([1000, 2000, 3000]))
          send me, {self(), fun.(elem)}
        end
       end)
    |> Enum.map(fn (pid) ->
        receive do {_pid, result} -> result end
       end)
  end
end
