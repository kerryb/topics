defmodule TopicsWeb.ErrorJSONTest do
  use TopicsWeb.ConnCase, async: true

  test "renders 404" do
    assert TopicsWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert TopicsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
