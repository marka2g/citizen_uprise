defmodule CitizenUprise.CandidatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CitizenUprise.Candidates` context.
  """

  @doc """
  Generate a candidate.
  """
  def candidate_fixture(attrs \\ %{}) do
    {:ok, candidate} =
      attrs
      |> Enum.into(%{
        fec_id: "some fec_id",
        fec_link: "some fec_link",
        first_name: "some first_name",
        last_name: "some last_name",
        party_abbrev: "some party_abbrev",
        race_status: "some race_status",
        state: "some state",
        zip: "some zip"
      })
      |> CitizenUprise.Candidates.create_candidate()

    candidate
  end
end
