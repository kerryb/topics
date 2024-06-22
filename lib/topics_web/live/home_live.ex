defmodule TopicsWeb.HomeLive do
  @moduledoc false
  use TopicsWeb, :live_view

  alias Phoenix.LiveView
  alias Topics.Suggestions

  @impl LiveView
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Topics.PubSub, "suggestions")
    end

    {:ok, stream(socket, :suggestions, Suggestions.list_suggestions())}
  end

  @impl LiveView
  def handle_info({:suggestion_created, suggestion}, socket) do
    {:noreply, stream_insert(socket, :suggestions, suggestion)}
  end
end
