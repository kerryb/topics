defmodule Topics.SuggestionsTest do
  use Topics.DataCase

  alias Topics.Suggestions

  describe "suggestions" do
    alias Topics.Suggestions.Suggestion

    @invalid_attrs %{title: nil}

    test "list_suggestions/0 returns all suggestions" do
      suggestion = insert!(:suggestion)
      assert Suggestions.list_suggestions() == [suggestion]
    end

    test "get_suggestion!/1 returns the suggestion with given id" do
      suggestion = insert!(:suggestion)
      assert Suggestions.get_suggestion!(suggestion.id) == suggestion
    end

    test "create_suggestion/1 with valid data creates a suggestion" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Suggestion{} = suggestion} = Suggestions.create_suggestion(valid_attrs)
      assert suggestion.title == "some title"
    end

    test "create_suggestion/1 with valid data broadcasts the new suggestion" do
      valid_attrs = %{title: "some title"}
      Phoenix.PubSub.subscribe(Topics.PubSub, "suggestions")

      {:ok, suggestion} = Suggestions.create_suggestion(valid_attrs)
      assert_receive {:suggestion_created, ^suggestion}
    end

    test "create_suggestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Suggestions.create_suggestion(@invalid_attrs)
    end

    test "update_suggestion/2 with valid data updates the suggestion" do
      suggestion = insert!(:suggestion)
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Suggestion{} = suggestion} = Suggestions.update_suggestion(suggestion, update_attrs)
      assert suggestion.title == "some updated title"
    end

    test "update_suggestion/2 with invalid data returns error changeset" do
      suggestion = insert!(:suggestion)
      assert {:error, %Ecto.Changeset{}} = Suggestions.update_suggestion(suggestion, @invalid_attrs)
      assert suggestion == Suggestions.get_suggestion!(suggestion.id)
    end

    test "delete_suggestion/1 deletes the suggestion" do
      suggestion = insert!(:suggestion)
      assert {:ok, %Suggestion{}} = Suggestions.delete_suggestion(suggestion)
      assert_raise Ecto.NoResultsError, fn -> Suggestions.get_suggestion!(suggestion.id) end
    end

    test "change_suggestion/1 returns a suggestion changeset" do
      suggestion = insert!(:suggestion)
      assert %Ecto.Changeset{} = Suggestions.change_suggestion(suggestion)
    end
  end
end
