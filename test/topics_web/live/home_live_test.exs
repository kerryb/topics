defmodule TopicsWeb.HomeLiveTest do
  use TopicsWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import Topics.Factory

  @endpoint TopicsWeb.Endpoint

  describe "TopicsWeb.HomeLive" do
    test "shows existing suggestions", %{conn: conn} do
      insert!(:suggestion, title: "Something interesting")
      insert!(:suggestion, title: "Another thing")

      {:ok, view, _html} = live(conn, "/")

      assert view |> element(".suggestion .title", "Something interesting") |> has_element?()
      assert view |> element(".suggestion .title", "Another thing") |> has_element?()
    end
  end
end
