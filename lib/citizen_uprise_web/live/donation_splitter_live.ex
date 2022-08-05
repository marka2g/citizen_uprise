defmodule CitizenUpriseWeb.DonationSplitterLive do
  use CitizenUpriseWeb, :live_view

  alias CitizenUprise.Candidates

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        matches: [],
        candidate: "",
        candidates: [],
        amount: nil,
        loading: false
      )
    {:ok, socket}
  end

  defp party_svg(party_abbrev) do
    case party_abbrev do
      "DEM" ->
        "images/Democratic_Disc_64.svg.png"
      "REP" ->
        "images/Republicanlogo_64.svg.png"
      _ ->
        "images/other_party.svg"
    end
  end

  def handle_event("suggest-candidate", %{"candidate" => prefix}, socket) do
    socket = assign(socket, matches: Candidates.suggest(prefix))
    {:noreply, socket}
  end

  def handle_event("candidate-search", %{"candidate" => cnd_str}, socket) do
    fec_id =
      cnd_str
      |> String.split("|")
      |> tl()
      |> hd()
      |> String.trim()

    send(self(), {:run_candidate_search, fec_id})

    socket =
      assign(socket,
        loading: true
    )
    {:noreply, socket}
  end

  def handle_info({:run_candidate_search, fec_id}, socket) do
    case Candidates.search_by_fec_id(fec_id) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No matching candidate")
          |> assign(candidates: [], loading: false)
        {:noreply, socket}
      candidates ->
        candidate = Enum.at(candidates, 0)
        socket =
          update(
            socket,
            :candidates,
            fn candidates -> [candidate | socket.assigns.candidates] end
          )
        {:noreply, assign(socket, loading: false)}
    end
  end
end
