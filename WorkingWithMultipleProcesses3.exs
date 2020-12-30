defmodule WorkingWithMultipleProcesses3 do
  @moduledoc"""
  > 子プロセスが終了するとき、子プロセスからの通知を待っていないことが問題になるだろうか?
  問題にはならない。子プロセス側でExitすると、exitメッセージが待ち行列に格納されるため。
  *) elixir -r WorkingWithMultipleProcesses3.exs -e "WorkingWithMultipleProcesses3.run()"
  """

  def sad_function() do
    exit(:boom)
  end

  def run() do
    Process.flag(:trap_exit, true)
    spawn_link(WorkingWithMultipleProcesses3, :sad_function, [])
    :timer.sleep(500)
    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect msg}")
    end
  end
end
