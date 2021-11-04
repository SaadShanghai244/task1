defmodule ConcurrencyTaskWeb.QueueController do
  use ConcurrencyTaskWeb, :controller

  alias ConcurrencyTask.Task1
  alias ConcurrencyTask.Task1.Queue

  def index(conn, _params) do
    queue = Task1.list_queue()
    render(conn, "index.html", queue: queue)
  end

  def new(conn, _params) do
    changeset = Task1.change_queue(%Queue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"queue" => queue_params}) do
    case Task1.create_queue(queue_params) do
      {:ok, queue} ->
        conn
        |> put_flash(:info, "Queue created successfully.")
        |> redirect(to: Routes.queue_path(conn, :show, queue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    queue = Task1.get_queue!(id)
    render(conn, "show.html", queue: queue)
  end

  def edit(conn, %{"id" => id}) do
    queue = Task1.get_queue!(id)
    changeset = Task1.change_queue(queue)
    render(conn, "edit.html", queue: queue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "queue" => queue_params}) do
    queue = Task1.get_queue!(id)

    case Task1.update_queue(queue, queue_params) do
      {:ok, queue} ->
        conn
        |> put_flash(:info, "Queue updated successfully.")
        |> redirect(to: Routes.queue_path(conn, :show, queue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", queue: queue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    queue = Task1.get_queue!(id)
    {:ok, _queue} = Task1.delete_queue(queue)

    conn
    |> put_flash(:info, "Queue deleted successfully.")
    |> redirect(to: Routes.queue_path(conn, :index))
  end
end
