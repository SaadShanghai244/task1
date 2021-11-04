defmodule ConcurrencyTask.Task1Fixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ConcurrencyTask.Task1` context.
  """

  @doc """
  Generate a queue.
  """
  def queue_fixture(attrs \\ %{}) do
    {:ok, queue} =
      attrs
      |> Enum.into(%{
        status: "some status"
      })
      |> ConcurrencyTask.Task1.create_queue()

    queue
  end
end
