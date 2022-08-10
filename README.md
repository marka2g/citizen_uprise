# CitizenUprise

![CitizenUprise - Donation Splitter](https://media.giphy.com/media/qLtXfJmPqADHsYMc2F/giphy.gif)

### ToDo
- [X] add `donations` 
- [ ] fix form input and button behavior
- [ ] add container around search and candidate list
- [ ] prevent `suggest-candidate` from dispaying existing `socket.assigns.candidates` in the `datalist`

### Contexts
> $ `mix phx.gen.context Candidates Candidate candidates last_name:string first_name:string fec_id:string fec_link:string state:string zip:string party_abbrev:string race_status:string`
> $ `mix phx.gen.context Donations Donation donations amount:float candidate_id:string user_id:string`

### Setup/Install Steps
> 1. $`mix phx.new citizen_uprise --live`
> 2. set up `dev.ex` and `test.ex` db creds
> 3. $`mix ecto.create`
> 4. $`cd citizen_uprise` 
> 5. $`mix phx.gen.auth `

<><><><><><><><><><><><><>

[1.6 and priv/static/assets](https://elixirforum.com/t/loading-images-and-assets-in-phoenix-1-6-2/43259/7)
