defmodule TimesheetSpa.Repo do
  use Ecto.Repo,
    otp_app: :timesheet_spa,
    adapter: Ecto.Adapters.Postgres
end
