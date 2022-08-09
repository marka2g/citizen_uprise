defmodule CitizenUprise.CandidatePopulator do
  alias CitizenUprise.Repo
  alias CitizenUprise.Candidates

  def from_csv do
    list_of_attrs_maps
    |> Enum.each(fn attrs -> Candidates.create_candidate(attrs) end)
  end

  defp list_of_attrs_maps do
    "../../priv/repo/candadates_cycle_22.csv"
      |> Path.expand(__DIR__)
      |> File.stream!
      |> CSV.decode()
      |> Enum.map(fn {:ok, row} -> build_attrs(row) end)
  end

  defp build_attrs(row) do
    %{
      fec_link: Enum.at(row, 0),
      last_name: parse_name(row, 0),
      first_name: parse_name(row, 1),
      state: Enum.at(row, 4),
      office: Enum.at(row, 3),
      fec_id: Enum.at(row, 2),
      race_status: Enum.at(row, 7), #incumb, challenger, open,
      party_abbrev: Enum.at(row, 6),
      zip: Enum.at(row, 17)
    }
  end

  defp parse_name(row, position) do
    str = Enum.at(row, 1) |> String.split(",") |> Enum.at(position)
    case is_binary(str) do
      true -> String.trim(str)
      _ -> ""
    end
  end
end
