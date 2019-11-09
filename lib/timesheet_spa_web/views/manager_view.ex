defmodule TimesheetSpaWeb.ManagerView do
  use TimesheetSpaWeb, :view
  alias TimesheetSpaWeb.ManagerView

  def render("index.json", %{managers: managers}) do
    %{data: render_many(managers, ManagerView, "manager.json")}
  end

  def render("show.json", %{manager: manager}) do
    %{data: render_one(manager, ManagerView, "manager.json")}
  end

  def render("manager.json", %{manager: manager}) do
    %{id: manager.id,
      email: manager.email,
      password_hash: manager.password_hash,
      name: manager.name}
  end
end
