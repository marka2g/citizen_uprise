defmodule CitizenUprise.Candidates.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :fec_id, :string
    field :fec_link, :string
    field :first_name, :string
    field :last_name, :string
    field :party_abbrev, :string
    field :race_status, :string
    field :state, :string
    field :zip, :string

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:last_name, :first_name, :fec_id, :fec_link, :state, :zip, :party_abbrev, :race_status])
    |> validate_required([:last_name, :first_name, :fec_id, :fec_link, :state, :zip, :party_abbrev, :race_status])
  end
end
