# CitizenUprise

![CitizenUprise - Donation Splitter](https://media.giphy.com/media/qLtXfJmPqADHsYMc2F/giphy.gif)

### To Use
> 1. $`git clone git@github.com:marka2g/citizen_uprise.git`
> 2. set up `dev.ex` and `test.ex` db creds
> 3. $`mix ecto.create`
> 4. $`cd citizen_uprise` 
> 5. $`iex -S mix phx.server`
> 6. Navigate to `localhost:4000`
> 7. Register
> 8. Navigate to `localhost:4000/donate`

### ToDo
- [X] add `donations` 
- [ ] fix form input and button behavior
- [ ] add container around search and candidate list
- [ ] ensure site is [wcag compliant](https://www.w3.org/WAI/standards-guidelines/wcag/glance/). review the [checklist here](https://www.a11yproject.com/checklist/)
- [ ] prevent `suggest-candidate` from dispaying existing `socket.assigns.candidates` in the `datalist`

### Contexts
> $ `mix phx.gen.context Candidates Candidate candidates last_name:string first_name:string fec_id:string fec_link:string state:string zip:string party_abbrev:string race_status:string`
> $ `mix phx.gen.context Donations Donation donations amount:float candidate_id:string user_id:string`

<><><><><><><><><><><><><>

[1.6 and priv/static/assets](https://elixirforum.com/t/loading-images-and-assets-in-phoenix-1-6-2/43259/7)
