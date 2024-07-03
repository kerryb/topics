defmodule TopicsWeb.LoginLive do
  @moduledoc false
  use TopicsWeb, :live_view

  alias Phoenix.LiveView
  alias Topics.Users
  alias Topics.Users.User

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(Users.change_user(%User{})))}
  end

  @impl LiveView
  def handle_event("login", %{"user" => params}, socket) do
    {:noreply, socket}
    # case Suggestions.create_suggestion(params) do
    #   {:ok, _} -> {:noreply, socket}
    #   {:error, changeset} -> {:noreply, assign(socket, form: to_form(changeset))}
    # end
  end
end
