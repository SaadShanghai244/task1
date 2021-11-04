defmodule ConcurrencyTask.Task1.Queue do
  use Ecto.Schema
  import Ecto.Changeset

  schema "queue" do
    field :status, :string


  end

  @doc false
  def changeset(queue, attrs) do
    queue
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
