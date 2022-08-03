defmodule CitizenUprise.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CitizenUprise.Repo,
      # Start the Telemetry supervisor
      CitizenUpriseWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CitizenUprise.PubSub},
      # Start the Endpoint (http/https)
      CitizenUpriseWeb.Endpoint
      # Start a worker by calling: CitizenUprise.Worker.start_link(arg)
      # {CitizenUprise.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CitizenUprise.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CitizenUpriseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
