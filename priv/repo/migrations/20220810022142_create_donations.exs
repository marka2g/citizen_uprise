defmodule CitizenUprise.Repo.Migrations.CreateDonations do
  use Ecto.Migration

  def change do
    create table(:donations) do
      add :amount, :float
      add :candidate_id, :string
      add :user_id, references(:users), null: false
      timestamps()
    end
  end
end
