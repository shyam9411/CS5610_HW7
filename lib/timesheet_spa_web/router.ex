defmodule TimesheetSpaWeb.Router do
  use TimesheetSpaWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TimesheetSpaWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/ajax", TimesheetSpaWeb do
    pipe_through :ajax

    resources "/workersession", WorkerSessionController, only: [:create], singleton: true
    resources "/managersession", ManagerSessionController, only: [:create], singleton: true
    resources "/tasksindex", TaskController, only: [:index]
    resources "/jobsindex", JobController, only: [:index]
    resources "/newTask", TaskController, only: [:create, :show]
    resources "/updateTask", TaskController, only: [:create, :update]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TimesheetSpaWeb do
  #   pipe_through :api
  # end
end
