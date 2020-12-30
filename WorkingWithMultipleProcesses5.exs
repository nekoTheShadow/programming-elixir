defmodule WorkingWithMultipleProcesses5 do
  @moduledoc"""
  spawn_monitorに変更しても:EXITが:DOWNになるだけで基本的な挙動は変わらない。
  *) elixir -r WorkingWithMultipleProcesses5.exs -e "WorkingWithMultipleProcesses5.run3()"
  *) elixir -r WorkingWithMultipleProcesses5.exs -e "WorkingWithMultipleProcesses5.run4()"
  """

  def sad_function3() do
    exit(:boom)
  end

  def run3() do
    Process.flag(:trap_exit, true)
    spawn_monitor(WorkingWithMultipleProcesses5, :sad_function3, [])
    :timer.sleep(500)
    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect msg}")
    end
  end

  def sad_function4() do
    raise "Unexpected Error"
  end

  def run4() do
    Process.flag(:trap_exit, true)
    spawn_monitor(WorkingWithMultipleProcesses5, :sad_function4, [])
    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect msg}")
    end
  end
end
