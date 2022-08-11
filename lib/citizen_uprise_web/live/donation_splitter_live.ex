defmodule CitizenUpriseWeb.DonationSplitterLive do
  use CitizenUpriseWeb, :live_view

  alias CitizenUprise.Candidates
  alias CitizenUprise.Donations
  # import Number.Currency

  def mount(_params, session, socket) do
    socket =
      assign(socket,
        matches: [],
        candidate: "",
        candidates: [],
        total_donation: 0.0,
        donations: [],
        loading: false
      )
    {:ok, assign_current_user(socket, session)}
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

  def handle_event("remove-candidate", %{"id" => id}, socket) do
    id = String.to_integer(id)
    candidate = Candidates.get_candidate_map(id)
    candidates = List.delete(socket.assigns.candidates, candidate)

    socket =
      assign(socket,
        candidates: candidates
      )

    {:noreply, socket}
  end

  def handle_event("add-donation", %{"donation" => donation, "candidate_id" => candidate_id}, socket) do
    donation = donation |> String.to_float

    candidate = Candidates.get_candidate!(candidate_id)
    donations = List.insert_at(socket.assigns.donations, 0, {candidate_id, candidate.last_name, donation})

    socket =
      assign(socket,
      donation: donation,
      donations: donations,
      total_donation: total_donation(donations)
    )
    {:noreply, socket}
  end

  def handle_event("remove-donation", %{"candidate-id" => candidate_id}, socket) do

    donation = Enum.find(socket.assigns.donations, fn {c_id, _ln, _amt} -> c_id == candidate_id end)
    donations = List.delete(socket.assigns.donations, donation)

    socket =
      assign(socket,
        donations: donations,
        total_donation: total_donation(donations)
      )
    {:noreply, socket}
  end

  def handle_event("donate", _, socket) do
    user = socket.assigns.current_user
    donations = socket.assigns.donations

    for donation <- donations  do
      [candidate_id, _, amount] = Tuple.to_list(donation)
      attrs =
        %{
          candidate_id: candidate_id,
          amount: amount,
          user_id: user.id
        }
      Donations.create_donation(attrs)
    end

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
        socket =
          update(
            socket,
            :candidates,
            fn _ -> [Enum.at(candidates, 0) | socket.assigns.candidates] end
          )
        {:noreply, assign(socket, loading: false)}
    end
  end

  defp total_donation(donations) do
    Enum.map(donations, fn {_, _, donation} -> donation end) |> Enum.sum()
  end

  defp party_svg(party_abbrev) do
    case party_abbrev do
      "DEM" ->
        "images/2000px-DemocraticLogo.svg_.png"
      "REP" ->
        "images/clipart-elephant-republican-3.png"
      _ ->
        "images/fist_of_rays.png"
    end
  end
end
