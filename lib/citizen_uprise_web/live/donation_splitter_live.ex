defmodule CitizenUpriseWeb.DonationSplitterLive do
  use CitizenUpriseWeb, :live_view

  alias CitizenUprise.Candidates
  alias CitizenUprise.Donations
  import Number.Currency

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        matches: [],
        candidate: "",
        candidates: [],
        candidate_count: 0,
        donation: 0.0,
        partial_donation: 0.0,
        loading: false
      )
    {:ok, socket}
  end

  def handle_event("set-donation", %{"donation" => donation}, socket) do
    donation = donation |> String.to_float
    IO.inspect(donation, label: "donation")
    {:noreply, assign(socket, donation: donation)}
  end

  def handle_event("update-donation", %{"partial_donation" => partial_donation}, socket) do
    IO.inspect(partial_donation, label: "partial_donation")
    {:noreply, assign(socket, partial_donation: partial_donation)}
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
        {:noreply, assign(socket, candidate_count: Enum.count(socket.assigns.candidates), loading: false)}
    end
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
end
