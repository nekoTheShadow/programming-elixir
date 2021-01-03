defmodule Sequence.Stash do
  use GenServer

  import Sequence.Server.State

  @me __MODULE__

  def start_link({initial_number, delta}) do
    GenServer.start_link(@me, {initial_number, delta}, name: @me)
  end

  def get() do
    GenServer.call(@me, {:get})
  end

  def update(state) do
    GenServer.cast(@me, {:update, state})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_call({:get}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:update, state}, _) do
    {:noreply, state}
  end
end
