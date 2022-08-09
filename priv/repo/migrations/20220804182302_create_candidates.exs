defmodule CitizenUprise.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :last_name, :string
      add :first_name, :string
      add :office, :string
      add :fec_id, :string
      add :fec_link, :string
      add :state, :string
      add :zip, :string
      add :party_abbrev, :string
      add :race_status, :string

      timestamps()
    end
  end
end
