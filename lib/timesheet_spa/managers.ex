defmodule TimesheetSpa.Managers do
  @moduledoc """
  The Managers context.
  """

  import Ecto.Query, warn: false
  alias TimesheetSpa.Repo

  alias TimesheetSpa.Managers.Manager

  @doc """
  Returns the list of managers.

  ## Examples

      iex> list_managers()
      [%Manager{}, ...]

  """
  def list_managers do
    #query = from u in Manager, where u.name = "Alice"
    #Repo.all(from u in "managers", where: u.name == "Alice", select: u.name)
    Repo.all(Manager)
  end

  @doc """
  Gets a single manager.

  Raises `Ecto.NoResultsError` if the Manager does not exist.

  ## Examples

      iex> get_manager!(123)
      %Manager{}

      iex> get_manager!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manager!(id), do: Repo.get!(Manager, id)


  def get_manager_by_email(email) do
    Repo.get_by(Manager, email: email)
  end

  def get_manager(id), do: Repo.get(Manager, id)

  def authenticate(email, pass) do
    user = Repo.get_by(Manager, email: email)
    case Argon2.check_pass(user, pass) do
      {:ok, user} -> user
      _ -> nil
    end
end
  @doc """
  Creates a manager.

  ## Examples

      iex> create_manager(%{field: value})
      {:ok, %Manager{}}

      iex> create_manager(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manager(attrs \\ %{}) do
    %Manager{}
    |> Manager.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manager.

  ## Examples

      iex> update_manager(manager, %{field: new_value})
      {:ok, %Manager{}}

      iex> update_manager(manager, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manager(%Manager{} = manager, attrs) do
    manager
    |> Manager.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manager.

  ## Examples

      iex> delete_manager(manager)
      {:ok, %Manager{}}

      iex> delete_manager(manager)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manager(%Manager{} = manager) do
    Repo.delete(manager)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manager changes.

  ## Examples

      iex> change_manager(manager)
      %Ecto.Changeset{source: %Manager{}}

  """
  def change_manager(%Manager{} = manager) do
    Manager.changeset(manager, %{})
  end

  @doc """
  Returns an `{:ok, user}` when user authentication is successful. Returns :nil otherwise.
  """
  def authenticate_user(email, password) do
    user = Repo.get_by(Manager, email: email)
    IO.inspect(user)
    case Argon2.check_pass(user, password) do
      {:ok, user} -> user
      _else       -> nil
    end
  end
end
