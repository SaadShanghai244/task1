defmodule Stack do
  use GenServer
  alias ConcurrencyTask.Task1

  def start_link() do
    IO.inspect("++++++++++++++start_link++++++++++")
    GenServer.start_link(__MODULE__,[])
  end

  def push(pid, element) do
    IO.inspect("++++++++++++++Push++++++++++")
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    IO.inspect("++++++++++++++Pop++++++++++")
    GenServer.call(pid, :pop)
  end

  # Server (callbacks)

  @impl true
  def init(stack) do
    IO.inspect("++++++++++++++init++++++++++")
    IO.inspect Task1.get_one()
    {:ok, stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    IO.inspect("++++++++++++++Handle Call++++++++++")
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    IO.inspect("++++++++++++++Handle Cast++++++++++")
    {:noreply, [element | state]}
  end
end
