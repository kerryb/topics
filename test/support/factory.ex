defmodule Topics.Factory do
  @moduledoc false
  alias Faker.Lorem
  alias Topics.Repo
  alias Topics.Suggestions.Suggestion

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end

  def build(:suggestion) do
    %Suggestion{title: Lorem.sentence(4)}
  end
end
