defmodule ConcurrencyTask.Repo.Migrations.CreateQueue do
  use Ecto.Migration

  def change do
    create table(:queue) do
      add :status, :string


    end
  end
end
