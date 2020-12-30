defmodule WorkingWithMultipleProcesses2 do
  @moduledoc """
  - プロセスから戻ってくる返事の順序は理論的に決定的であるか? 実際は?
    - 実装はrun1
    - 非決定的。pid1とpid2のどちらが先にメッセージを返してくるのか、親プロセスにはわからない。
    - ただし実際にはechoの処理は高速で終了するので、pid1->pid2の順番で返事が返ってくる。
  - もしその答えが「No」であるなら、どうすれば順序を決定的にできるだろうか?
    - run2のように実装する
  """

  def echo() do
    receive do
      {pid, body} -> send(pid, {self(), body})
    end
  end

  def run1() do
    pid1 = spawn(WorkingWithMultipleProcesses, :echo, [])
    pid2 = spawn(WorkingWithMultipleProcesses, :echo, [])

    send(pid1, {self(), "betty"})
    send(pid2, {self(), "fred"})
    receive do
      {_, body} -> IO.puts(body)
    end
  end

  def run2() do
    pid1 = spawn(WorkingWithMultipleProcesses, :echo, [])
    pid2 = spawn(WorkingWithMultipleProcesses, :echo, [])

    send(pid1, {self(), "betty"})
    send(pid2, {self(), "fred"})

    for pid_a <- [pid1, pid2] do
      receive do
        {pid_b, body} when pid_a === pid_b -> body
      end
    end
    |> inspect()
    |> IO.puts()
  end
end
