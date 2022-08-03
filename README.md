# CitizenUprise

### To Add
- tailwindcss
  - maybe `dartcss` if its not a total p.i.t.a 
- `mix phx.gen.auth` with live_view
  - roles - `admin`, `breeder`, `user` -> see [this blog post](https://www.leanpanda.com/blog/authentication-and-authorisation-in-phoenix-liveview/#step-3-update-the-live-views-generated-with-phx-gen-live-to-perform-the-checks-ensuring-a-user-can-really-access-a-given-route) that uses `ecto.enum` for `roles`
- merch account/payment gateway - see [this blog post](https://www.10buds.com/industry/payment-collection-for-cannabis-businesses/)
- drag&drop -> [tutorial](https://www.youtube.com/watch?v=U1EKT7WT_Ic)

### Setup/Install Steps
> 1. $`mix phx.new citizen_uprise --live`
> 2. set up `dev.ex` and `test.ex` db creds
> 3. $`mix ecto.create`
> 4. $`cd citizen_uprise` 
> 5. $`mix phx.gen.auth `


<><><><><><><><><><><><><>

[1.6 and priv/static/assets](https://elixirforum.com/t/loading-images-and-assets-in-phoenix-1-6-2/43259/7)