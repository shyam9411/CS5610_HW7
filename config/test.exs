use Mix.Config

# Configure your database
config :timesheet_spa, TimesheetSpa.Repo,
  username: "timesheet_spa",
  password: "Aesooj3iel3f",
  database: "timesheet_spa_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :timesheet_spa, TimesheetSpaWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
