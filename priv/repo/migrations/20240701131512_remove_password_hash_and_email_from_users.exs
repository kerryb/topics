defmodule Topics.Repo.Migrations.RemovePasswordHashAndEmailFromUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password_hash, :string
      remove :email, :string
    end
  end
end
