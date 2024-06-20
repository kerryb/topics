defmodule Topics.TopicTest do
  use Topics.DataCase

  alias Topics.Topic

  describe "suggestions" do
    import Topics.TopicFixtures

    alias Topics.Topic.Suggestion

    @invalid_attrs %{title: nil}

    test "list_suggestions/0 returns all suggestions" do
      suggestion = suggestion_fixture()
      assert Topic.list_suggestions() == [suggestion]
    end

    test "get_suggestion!/1 returns the suggestion with given id" do
      suggestion = suggestion_fixture()
      assert Topic.get_suggestion!(suggestion.id) == suggestion
    end

    test "create_suggestion/1 with valid data creates a suggestion" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Suggestion{} = suggestion} = Topic.create_suggestion(valid_attrs)
      assert suggestion.title == "some title"
    end

    test "create_suggestion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topic.create_suggestion(@invalid_attrs)
    end

    test "update_suggestion/2 with valid data updates the suggestion" do
      suggestion = suggestion_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Suggestion{} = suggestion} = Topic.update_suggestion(suggestion, update_attrs)
      assert suggestion.title == "some updated title"
    end

    test "update_suggestion/2 with invalid data returns error changeset" do
      suggestion = suggestion_fixture()
      assert {:error, %Ecto.Changeset{}} = Topic.update_suggestion(suggestion, @invalid_attrs)
      assert suggestion == Topic.get_suggestion!(suggestion.id)
    end

    test "delete_suggestion/1 deletes the suggestion" do
      suggestion = suggestion_fixture()
      assert {:ok, %Suggestion{}} = Topic.delete_suggestion(suggestion)
      assert_raise Ecto.NoResultsError, fn -> Topic.get_suggestion!(suggestion.id) end
    end

    test "change_suggestion/1 returns a suggestion changeset" do
      suggestion = suggestion_fixture()
      assert %Ecto.Changeset{} = Topic.change_suggestion(suggestion)
    end
  end
end
