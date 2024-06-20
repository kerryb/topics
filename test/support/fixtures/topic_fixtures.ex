defmodule Topics.TopicFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Topics.Topic` context.
  """

  @doc """
  Generate a suggestion.
  """
  def suggestion_fixture(attrs \\ %{}) do
    {:ok, suggestion} =
      attrs
      |> Enum.into(%{
        title: "some title"
      })
      |> Topics.Topic.create_suggestion()

    suggestion
  end
end
