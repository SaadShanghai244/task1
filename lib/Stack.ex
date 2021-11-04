defmodule Stack do
  use GenServer
  alias ConcurrencyTask.Task1

  def start_link(args) do
    IO.inspect("++++++++++++++start_link++++++++++")
    GenServer.start_link(__MODULE__, args)
  end

  def push(pid, element) do
    IO.inspect("++++++++++++++Push++++++++++")
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    IO.inspect("++++++++++++++Pop++++++++++")
    GenServer.cast(pid, :pop)
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    IO.inspect("++++++++++++++init++++++++++")
    solution(state)
    schedule_push()
    schedule_pop()
    # IO.inspect Task1.get_one()
    {:ok, state}
  end


  @impl true
  def handle_cast(:pop, state) do
    IO.inspect("++++++++++++++Handle Cast for Pop ++++++++++")
    IO.inspect List.last(state)

    {:ok, last} = List.last(state)
    Task1.update_queue(last, %{status: "In Processing"})
    # Status is updated with "In Processing" before pop which shows its now in poping phase
    state = List.delete_at(state, -1)
    :timer.sleep(2000)
    Task1.update_queue(last, %{status: "Processed"})
    # Status is updated with "Processed" after pop which shows its now poped

    {:noreply,state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    IO.inspect("++++++++++++++Handle Cast for Push+++++++++")
    {:noreply, [element | state]}
  end
  @impl true
  def handle_info(:push, state) do
    IO.inspect "+++++++++++Handle Info for Push++++++++++"
    solution(state)
    schedule_push()
    {:noreply, state}
  end
  @impl true
  def handle_info(:pop, state) do
    IO.inspect "+++++++++++Handle Info for Pop++++++++++"
    pid = self()
    pop(pid)
    schedule_pop()
    {:noreply, state}
  end

  defp solution(state) do
    IO.inspect "+++++++++++Solution++++++++++"
    len = Enum.count(state)
    IO.inspect(len)
    if len < 6 do
      Enum.each(0..(5 - len), fn x ->
        pid = self()
        try do
          process = Task1.get_one() |> List.first()
          process = Task1.update_queue(process, %{status: "In queue"})
          # Status is updated with "In queue" after pushed in queue

          push(pid, process)

        rescue
          FunctionClauseError -> IO.puts("")
        end
      end)
    end
  end
  defp schedule_push do
    Process.send_after(self(), :push, 20000)
  end
  defp schedule_pop do
    Process.send_after(self(), :pop, 60000)
  end
end
