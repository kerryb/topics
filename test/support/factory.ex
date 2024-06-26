defmodule Topics.Factory do
  @moduledoc false
  alias Faker.Lorem
  alias Faker.Person
  alias Topics.Repo
  alias Topics.Suggestions.Suggestion
  alias Topics.Users.User

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end

  def build(:suggestion) do
    %Suggestion{title: Lorem.sentence(4)}
  end

  def build(:user) do
    %User{
      name: Person.name(),
      username: to_string(:rand.uniform(99_999_999) + 100_000_000)
    }
  end
end
