defmodule ConcurrencyTask.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:status])
    |> validate_required([:status])
  end
end
