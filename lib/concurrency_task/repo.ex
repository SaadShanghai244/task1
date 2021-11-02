defmodule ConcurrencyTask.Repo do
  use Ecto.Repo,
    otp_app: :concurrency_task,
    adapter: Ecto.Adapters.Postgres
end
