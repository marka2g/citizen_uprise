defmodule CitizenUpriseWeb.DonationSplitterLive do
  use CitizenUpriseWeb, :live_view

  alias CitizenUprise.Candidates

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
      matches: [],
      candidate: "",
      candidates: [],
      loading: false
    )
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Split Up Your Donation</h1>
    <div id="search">
      <form id="candidate-search"
            phx-submit="candidate-search"
            phx-change="suggest-candidate">
        <input type="text" name="candidate" value={@candidate}
               placeholder="Candidate Search"
               autocomplete="off"
               list="matches"
               phx-debounce="250"
               readonly={@loading}
               />
        <button type="submit">
          <img src="images/search.svg">
        </button>
      </form>

      <datalist id="matches">
        <%= for match <- @matches do %>
          <option value={match}><%= match %></option>
        <% end %>
      </datalist>

      <div class="candidates">
        <ul>
          <%= for candidate <- @candidates do %>
            <li>
              <div class="first-line">
                <div class="name"><%= candidate.first_name %> <%= candidate.last_name %></div>
              </div>
              <div class="second-line">
              </div>
            </li>
          <% end %>
        </ul>
      </div>
    </div>
    """
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
