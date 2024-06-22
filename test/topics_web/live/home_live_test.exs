defmodule TopicsWeb.HomeLiveTest do
  use TopicsWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import Topics.Factory

  alias Topics.Suggestions

  @endpoint TopicsWeb.Endpoint

  describe "TopicsWeb.HomeLive" do
    test "shows existing suggestions", %{conn: conn} do
      insert!(:suggestion, title: "Something interesting")
      insert!(:suggestion, title: "Another thing")

      {:ok, view, _html} = live(conn, "/")

      assert view |> element(".suggestion .title", "Something interesting") |> has_element?()
      assert view |> element(".suggestion .title", "Another thing") |> has_element?()
    end

    test "appends new suggestions", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      Suggestions.create_suggestion(%{title: "Something"})

      assert view |> element(".suggestion .title", "Something") |> has_element?()
    end
  end
end
