defmodule Client do
  def start do
    participant = :global.whereis_name(:participant)
    client = spawn(__MODULE__, :receiver, [[]])
    if participant === :undefined do
      send client, {:tick, [client], client}
      :global.register_name(:participant, client)
    else
      send participant, {:join, client}
      :global.re_register_name(:participant, client)
    end
  end

  def receiver(queue) do
    receive do
      {:join, pid} ->
        IO.puts "#{inspect pid} join in #{inspect self()}"
        receiver([pid | queue])

      {:tick, clients, sender_pid} ->
        IO.puts "tick from #{inspect sender_pid}, tock in #{inspect self()}"
        :timer.sleep(2000)

        pids = queue ++ clients
        x = Enum.find_index(pids, fn pid -> self() === pid end)
        if x === length(pids) - 1 do
          send Enum.at(pids, 0), {:tick, pids, self()}
        else
          send Enum.at(pids, x+1), {:tick, pids, self()}
        end
        receiver([])
    end
  end
end
