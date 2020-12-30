defmodule WorkingWithMultipleProcesses4 do
  @moduledoc"""
  例外が発生した後、EXITを示すメッセージが送信される。
  *) elixir -r WorkingWithMultipleProcesses4.exs -e "WorkingWithMultipleProcesses4.run()"
  """

  def sad_function() do
    raise "Unexpected Error"
  end

  def run() do
    Process.flag(:trap_exit, true)
    spawn_link(WorkingWithMultipleProcesses4, :sad_function, [])
    receive do
      msg -> IO.puts("MESSAGE RECEIVED: #{inspect msg}")
    end
  end
end
