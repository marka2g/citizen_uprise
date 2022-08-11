# CitizenUprise

![CitizenUprise - Donation Splitter](https://media.giphy.com/media/i9VPX5X6XnmHiY9NZc/giphy.gif)

### To Use
> 1. $`git clone git@github.com:marka2g/citizen_uprise.git`
> 2. $`cd citizen_uprise` 
> 3. set up `dev.ex` and `test.ex` db creds
> 4. $`mix ecto.create`
> 5. $`mix run priv/repo/seeds.exs`
> 6. $`iex -S mix phx.server`
> 7. Navigate to `localhost:4000`
> 8. Register
> 9. Navigate to `localhost:4000/donate`

### ToDo
- [X] add `donations` 
- [ ] fix form input and button behavior
- [X] add `flex-box` for layout
  - [X] ~~add container around search and candidate list~~
- [ ] add unique to `candidate.fec_id` - seeds can double, breaking `Candidates.search_by_fec_id(fec_id)`
  - [ ] write a test for the `handle_info(:run_candidate_search)` calling it
- [ ] prevent `suggest-candidate` from dispaying existing `socket.assigns.candidates` in the `datalist`
- [ ] ensure site is [wcag compliant](https://www.w3.org/WAI/standards-guidelines/wcag/glance/). review the [checklist here](https://www.a11yproject.com/checklist/)

### Context Generation
> $ `mix phx.gen.context Candidates Candidate candidates last_name:string first_name:string fec_id:string fec_link:string state:string zip:string party_abbrev:string race_status:string`
> 
> $ `mix phx.gen.context Donations Donation donations amount:float candidate_id:string user_id:string`

<><><><><><><><><><><><><>

[1.6 and priv/static/assets](https://elixirforum.com/t/loading-images-and-assets-in-phoenix-1-6-2/43259/7)
