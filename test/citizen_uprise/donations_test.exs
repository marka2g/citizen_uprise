defmodule CitizenUprise.DonationsTest do
  use CitizenUprise.DataCase

  alias CitizenUprise.Donations

  describe "donations" do
    alias CitizenUprise.Donations.Donation

    import CitizenUprise.DonationsFixtures

    @invalid_attrs %{amount: nil, candidate_id: nil, user_id: nil}

    test "list_donations/0 returns all donations" do
      donation = donation_fixture()
      assert Donations.list_donations() == [donation]
    end

    test "get_donation!/1 returns the donation with given id" do
      donation = donation_fixture()
      assert Donations.get_donation!(donation.id) == donation
    end

    test "create_donation/1 with valid data creates a donation" do
      valid_attrs = %{amount: 120.5, candidate_id: "some candidate_id", user_id: "some user_id"}

      assert {:ok, %Donation{} = donation} = Donations.create_donation(valid_attrs)
      assert donation.amount == 120.5
      assert donation.candidate_id == "some candidate_id"
      assert donation.user_id == "some user_id"
    end

    test "create_donation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Donations.create_donation(@invalid_attrs)
    end

    test "update_donation/2 with valid data updates the donation" do
      donation = donation_fixture()
      update_attrs = %{amount: 456.7, candidate_id: "some updated candidate_id", user_id: "some updated user_id"}

      assert {:ok, %Donation{} = donation} = Donations.update_donation(donation, update_attrs)
      assert donation.amount == 456.7
      assert donation.candidate_id == "some updated candidate_id"
      assert donation.user_id == "some updated user_id"
    end

    test "update_donation/2 with invalid data returns error changeset" do
      donation = donation_fixture()
      assert {:error, %Ecto.Changeset{}} = Donations.update_donation(donation, @invalid_attrs)
      assert donation == Donations.get_donation!(donation.id)
    end

    test "delete_donation/1 deletes the donation" do
      donation = donation_fixture()
      assert {:ok, %Donation{}} = Donations.delete_donation(donation)
      assert_raise Ecto.NoResultsError, fn -> Donations.get_donation!(donation.id) end
    end

    test "change_donation/1 returns a donation changeset" do
      donation = donation_fixture()
      assert %Ecto.Changeset{} = Donations.change_donation(donation)
    end
  end
end
