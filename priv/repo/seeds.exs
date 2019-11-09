# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimesheetSpa.Repo.insert!(%TimesheetSpa.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TimesheetSpa.Repo
alias TimesheetSpa.Managers.Manager
alias TimesheetSpa.Workers.Worker
alias TimesheetSpa.Tasks.Task
alias TimesheetSpa.Jobs.Job

pw = Argon2.hash_pwd_salt("password")

Repo.insert!(%Manager{name: "Manager 1", email: "mgr1@example.com", password_hash: pw})
Repo.insert!(%Manager{name: "Manager 2", email: "mgr2@example.com", password_hash: pw})

Repo.insert!(%Worker{name: "Worker 1", email: "worker1@example.com", password_hash: pw})
Repo.insert!(%Worker{name: "Worker 2", email: "worker2@example.com", password_hash: pw})

Repo.insert!(%Job{hours: 1, description: "random description", code: "111", manager_id: 1, name: "random name"})
Repo.insert!(%Job{hours: 2, description: "random description 2", code: "555", manager_id: 2, name: "random name"})

Repo.insert!(%Task{status: true, hours: 1, description: "random desc", job_id: 1, worker_id: 1})
Repo.insert!(%Task{status: false, hours: 2, description: "random desc 2", job_id: 2, worker_id: 2})
