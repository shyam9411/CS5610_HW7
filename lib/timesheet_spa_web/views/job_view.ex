defmodule TimesheetSpaWeb.JobView do
  use TimesheetSpaWeb, :view
  alias TimesheetSpaWeb.JobView

  def render("index.json", %{jobs: jobs}) do
    %{data: render_many(jobs, JobView, "job.json")}
  end

  def render("show.json", %{job: job}) do
    %{data: render_one(job, JobView, "job.json")}
  end

  def render("job.json", %{job: job}) do
    %{id: job.id,
      hours: job.hours,
      description: job.description,
      code: job.code,
      code: job.code,
      name: job.name,
      manager_id: job.manager_id}
  end
end
