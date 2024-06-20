defmodule Topics.Topic.Suggestion do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "suggestions" do
    field :title, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(suggestion, attrs) do
    suggestion
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
