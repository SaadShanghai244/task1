defmodule ConcurrencyTask.Task1 do
  @moduledoc """
  The Task1 context.
  """

  import Ecto.Query, warn: false
  alias ConcurrencyTask.Repo

  alias ConcurrencyTask.Task1.Queue

  @doc """
  Returns the list of queue.

  ## Examples

      iex> list_queue()
      [%Queue{}, ...]

  """
  def list_queue do
    Repo.all(Queue)
  end

  @doc """
  Gets a single queue.

  Raises `Ecto.NoResultsError` if the Queue does not exist.

  ## Examples

      iex> get_queue!(123)
      %Queue{}

      iex> get_queue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_queue!(id), do: Repo.get!(Queue, id)

  @doc """
  Creates a queue.

  ## Examples

      iex> create_queue(%{field: value})
      {:ok, %Queue{}}

      iex> create_queue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_queue(attrs \\ %{}) do
    %Queue{}
    |> Queue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a queue.

  ## Examples

      iex> update_queue(queue, %{field: new_value})
      {:ok, %Queue{}}

      iex> update_queue(queue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_queue(%Queue{} = queue, attrs) do
    queue
    |> Queue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a queue.

  ## Examples

      iex> delete_queue(queue)
      {:ok, %Queue{}}

      iex> delete_queue(queue)
      {:error, %Ecto.Changeset{}}

  """


  def get_all() do
   Repo.all(Queue)
  end

  def delete_queue(%Queue{} = queue) do
    Repo.delete(queue)
  end


  @doc """
  Returns an `%Ecto.Changeset{}` for tracking queue changes.

  ## Examples

      iex> change_queue(queue)
      %Ecto.Changeset{data: %Queue{}}

  """
  def change_queue(%Queue{} = queue, attrs \\ %{}) do
    Queue.changeset(queue, attrs)
  end
end
