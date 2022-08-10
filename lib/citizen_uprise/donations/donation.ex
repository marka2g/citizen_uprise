defmodule CitizenUprise.Donations.Donation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "donations" do
    field :amount, :float
    field :candidate_id, :string
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(donation, attrs) do
    donation
    |> cast(attrs, [:amount, :candidate_id, :user_id])
    |> validate_required([:amount, :candidate_id, :user_id])
  end
end
