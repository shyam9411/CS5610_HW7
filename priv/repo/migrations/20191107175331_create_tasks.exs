defmodule TimesheetSpa.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :status, :boolean, default: false, null: false
      add :hours, :integer
      add :description, :string
      add :job_id, references(:jobs, on_delete: :nothing)
      add :worker_id, references(:workers, on_delete: :nothing)

      timestamps()
    end

  end
end
