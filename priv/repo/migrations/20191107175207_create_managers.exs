defmodule TimesheetSpa.Repo.Migrations.CreateManagers do
  use Ecto.Migration

  def change do
    create table(:managers) do
      add :email, :string
      add :password_hash, :string
      add :name, :string

      timestamps()
    end

  end
end
