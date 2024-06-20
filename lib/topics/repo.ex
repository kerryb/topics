defmodule Topics.Repo do
  use Ecto.Repo,
    otp_app: :topics,
    adapter: Ecto.Adapters.Postgres
end
