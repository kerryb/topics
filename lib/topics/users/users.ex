defmodule Topics.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Topics.Repo
  alias Topics.Users.LDAP
  alias Topics.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Returns nil if the User does not exist.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user(456)
      nil

  """
  def get_user(nil), do: nil
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    case %User{}
         |> User.changeset(attrs)
         |> Repo.insert() do
      {:ok, user} ->
        Phoenix.PubSub.broadcast!(Topics.PubSub, "users", {:user_created, user})
        {:ok, user}

      error ->
        error
    end
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Logs a user in.

  If login succeeds, a user record is created if none exists. If a record
  exists, the name is updated to match the one from LDAP.

  ## Examples

      iex> login(username, password)
      {:ok, %User{})

      iex> login(username, bad_password)
      :error

  """
  def login(username, password) do
    {:ok, name} = LDAP.validate(username, password)
    Repo.insert(%User{username: username, name: name}, on_conflict: [set: [name: name]], conflict_target: :username)
  end
end
