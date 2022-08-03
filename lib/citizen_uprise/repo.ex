defmodule CitizenUprise.Repo do
  use Ecto.Repo,
    otp_app: :citizen_uprise,
    adapter: Ecto.Adapters.Postgres
end
