defmodule Topics.Auth.User do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :password_hash, :string
    field :email, :string

    timestamps(type: :utc_datetime)

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :name, :email])
    |> validate_required([:username, :password_hash, :name, :email])
  end
end
