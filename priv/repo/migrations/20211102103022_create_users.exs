defmodule ConcurrencyTask.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :status, :string

      timestamps()
    end
  end
end
