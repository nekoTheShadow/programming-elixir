defmodule Ticker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients])
      after @interval ->
        IO.puts "tick"
        if clients !== [] do
          [next_client | tail] = clients
          send next_client, {:tick, tail, self()}
        end
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick, clients, sender_pid} ->
        IO.puts "tock in client from #{inspect sender_pid}"
        if clients !== [] do
          [next_client | tail] = clients
          send next_client, {:tick, tail, self()}
        end
        receiver()
    end
  end
end
