defmodule CitizenUprise.Candidates do
  @moduledoc """
  The Candidates context.
  """

  import Ecto.Query, warn: false
  alias CitizenUprise.Repo
  alias CitizenUprise.Candidates.Candidate

  def suggest(""), do: []

  def suggest(prefix) do
    Enum.filter(candidate_names(), &has_prefix?(&1, prefix))
  end

  defp has_prefix?(candidate, prefix) do
    String.contains?(String.downcase(candidate), String.downcase(prefix))
  end

  defp candidate_names do
    list_candidates()
    |> Enum.map(fn cnd -> "#{cnd.first_name} #{cnd.last_name} | #{cnd.fec_id}" end)
  end

  # theres gotta be a better way
  def search_by_fec_id(fec_id) do
    list_candidates()
    |> Enum.filter(&(&1.fec_id == fec_id))
    |> Enum.map(&%{fec_id: &1.fec_id,
          fec_link: &1.fec_link,
          first_name: &1.first_name,
          id: &1.id,
          inserted_at: &1.inserted_at,
          last_name: &1.last_name,
          office: &1.office,
          party_abbrev: &1.party_abbrev,
          race_status: &1.race_status,
          state: &1.state,
          updated_at: &1.updated_at,
          zip: &1.zip
        }
      )
  end

  @doc """
  Returns the list of candidates.

  ## Examples

      iex> list_candidates()
      [%Candidate{}, ...]

  """
  def list_candidates do
    Repo.all(Candidate)
  end

  # needs refactor
  def get_candidate_map(id) do
    case Repo.get(Candidate, id) do
      nil ->
        %{}
      candidate ->
        %{
          fec_id: candidate.fec_id,
          fec_link: candidate.fec_link,
          first_name: candidate.first_name,
          id: candidate.id,
          inserted_at: candidate.inserted_at,
          last_name: candidate.last_name,
          office: candidate.office,
          party_abbrev: candidate.party_abbrev,
          race_status: candidate.race_status,
          state: candidate.state,
          updated_at: candidate.updated_at,
          zip: candidate.zip
        }
    end
  end

  @doc """
  Gets a single candidate.

  Raises `Ecto.NoResultsError` if the Candidate does not exist.

  ## Examples

      iex> get_candidate!(123)
      %Candidate{}

      iex> get_candidate!(456)
      ** (Ecto.NoResultsError)

  """
  def get_candidate!(id), do: Repo.get!(Candidate, id)

  @doc """
  Creates a candidate.

  ## Examples

      iex> create_candidate(%{field: value})
      {:ok, %Candidate{}}

      iex> create_candidate(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_candidate(attrs \\ %{}) do
    %Candidate{}
    |> Candidate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a candidate.

  ## Examples

      iex> update_candidate(candidate, %{field: new_value})
      {:ok, %Candidate{}}

      iex> update_candidate(candidate, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_candidate(%Candidate{} = candidate, attrs) do
    candidate
    |> Candidate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a candidate.

  ## Examples

      iex> delete_candidate(candidate)
      {:ok, %Candidate{}}

      iex> delete_candidate(candidate)
      {:error, %Ecto.Changeset{}}

  """
  def delete_candidate(%Candidate{} = candidate) do
    Repo.delete(candidate)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking candidate changes.

  ## Examples

      iex> change_candidate(candidate)
      %Ecto.Changeset{data: %Candidate{}}

  """
  def change_candidate(%Candidate{} = candidate, attrs \\ %{}) do
    Candidate.changeset(candidate, attrs)
  end
end
