defmodule TopicsWeb.LoginLiveTest do
  use TopicsWeb.ConnCase, async: true

  import Phoenix.ConnTest
  import Phoenix.LiveViewTest
  import Topics.Factory

  alias Topics.Suggestions

  @endpoint TopicsWeb.Endpoint

  describe "TopicsWeb.LoginLive" do
    test "allows login", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/login")

      view |> element("form") |> render_submit(%{"user" => %{"username" => "employee", "password" => "Secret123"}})

      assert view |> element("p", "Test Employee") |> has_element?()
    end
  end
end
