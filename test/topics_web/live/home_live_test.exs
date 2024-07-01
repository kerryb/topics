defmodule TopicsWeb.HomeLiveTest do
  use TopicsWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import Topics.Factory

  alias Topics.Suggestions

  @endpoint TopicsWeb.Endpoint

  describe "TopicsWeb.HomeLive, when signed in" do
    setup %{conn: conn} do
      user = insert!(:user)
      %{conn: conn |> SessionHelper.prepare_session() |> put_session(:user_id, user.id)}
    end

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

    test "allows suggestions to be added when signed in", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      view |> element("form") |> render_submit(%{"suggestion" => %{"title" => "Something"}})

      assert view |> element(".suggestion .title", "Something") |> has_element?()
    end
  end
end
