defmodule Topics.Repo.Migrations.CreateSuggestions do
  use Ecto.Migration

  def change do
    create table(:suggestions) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end
  end
end
