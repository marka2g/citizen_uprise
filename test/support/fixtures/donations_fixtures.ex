defmodule CitizenUprise.DonationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CitizenUprise.Donations` context.
  """

  @doc """
  Generate a donation.
  """
  def donation_fixture(attrs \\ %{}) do
    {:ok, donation} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        candidate_id: "some candidate_id",
        user_id: "some user_id"
      })
      |> CitizenUprise.Donations.create_donation()

    donation
  end
end
