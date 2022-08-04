defmodule CitizenUprise.CandidatesTest do
  use CitizenUprise.DataCase

  alias CitizenUprise.Candidates

  describe "candidates" do
    alias CitizenUprise.Candidates.Candidate

    import CitizenUprise.CandidatesFixtures

    @invalid_attrs %{fec_id: nil, fec_link: nil, first_name: nil, last_name: nil, party_abbrev: nil, race_status: nil, state: nil, zip: nil}

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Candidates.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Candidates.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      valid_attrs = %{fec_id: "some fec_id", fec_link: "some fec_link", first_name: "some first_name", last_name: "some last_name", party_abbrev: "some party_abbrev", race_status: "some race_status", state: "some state", zip: "some zip"}

      assert {:ok, %Candidate{} = candidate} = Candidates.create_candidate(valid_attrs)
      assert candidate.fec_id == "some fec_id"
      assert candidate.fec_link == "some fec_link"
      assert candidate.first_name == "some first_name"
      assert candidate.last_name == "some last_name"
      assert candidate.party_abbrev == "some party_abbrev"
      assert candidate.race_status == "some race_status"
      assert candidate.state == "some state"
      assert candidate.zip == "some zip"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Candidates.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      update_attrs = %{fec_id: "some updated fec_id", fec_link: "some updated fec_link", first_name: "some updated first_name", last_name: "some updated last_name", party_abbrev: "some updated party_abbrev", race_status: "some updated race_status", state: "some updated state", zip: "some updated zip"}

      assert {:ok, %Candidate{} = candidate} = Candidates.update_candidate(candidate, update_attrs)
      assert candidate.fec_id == "some updated fec_id"
      assert candidate.fec_link == "some updated fec_link"
      assert candidate.first_name == "some updated first_name"
      assert candidate.last_name == "some updated last_name"
      assert candidate.party_abbrev == "some updated party_abbrev"
      assert candidate.race_status == "some updated race_status"
      assert candidate.state == "some updated state"
      assert candidate.zip == "some updated zip"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Candidates.update_candidate(candidate, @invalid_attrs)
      assert candidate == Candidates.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Candidates.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Candidates.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Candidates.change_candidate(candidate)
    end
  end
end
