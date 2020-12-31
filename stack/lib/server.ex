defmodule Stack.Server do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def pop() do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  def kill() do
    GenServer.cast __MODULE__, {:kill}
  end

  def init(_) do
    {:ok, Stack.Stash.get()}
  end

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    {:reply, head, tail}
  end

  def handle_cast({:push, value}, stack) do
    {:noreply, [value | stack]}
  end

  def handle_cast({:kill}, _stack) do
    raise "KILL"
  end

  def terminate(_reason, stack) do
    Stack.Stash.update(stack)
  end
end
