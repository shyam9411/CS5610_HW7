# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :timesheet_spa,
  ecto_repos: [TimesheetSpa.Repo]

# Configures the endpoint
config :timesheet_spa, TimesheetSpaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Tu053Mxt2pYqBaxlOfz9Y9Ae9+eBMtLiUHzJ2YA++/5WjSXtnmCT3A+L1J9rpU/H",
  render_errors: [view: TimesheetSpaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TimesheetSpa.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
