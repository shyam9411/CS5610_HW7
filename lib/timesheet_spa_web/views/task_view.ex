defmodule TimesheetSpaWeb.TaskView do
  use TimesheetSpaWeb, :view
  alias TimesheetSpaWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      status: task.status,
      hours: task.hours,
      description: task.description,
      job_id: task.job_id,
      worker_id: task.worker_id
    }
  end
end
