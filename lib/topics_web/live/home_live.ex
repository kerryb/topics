defmodule TopicsWeb.HomeLive do
  @moduledoc false
  use TopicsWeb, :live_view

  alias Phoenix.LiveView
  alias Topics.Suggestions
  alias Topics.Suggestions.Suggestion

  @impl LiveView
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Topics.PubSub, "suggestions")
    end

    {:ok,
     socket
     |> assign(form: to_form(Suggestions.change_suggestion(%Suggestion{})))
     |> stream(:suggestions, Suggestions.list_suggestions())}
  end

  @impl LiveView
  def handle_event("create", %{"suggestion" => params}, socket) do
    case Suggestions.create_suggestion(params) do
      {:ok, _} -> {:noreply, socket}
      {:error, changeset} -> {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  @impl LiveView
  def handle_info({:suggestion_created, suggestion}, socket) do
    {:noreply, stream_insert(socket, :suggestions, suggestion)}
  end
end
