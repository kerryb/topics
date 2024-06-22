defmodule TopicsWeb.HomeLive do
  @moduledoc false
  use TopicsWeb, :live_view

  alias Phoenix.LiveView
  alias Topics.Topic

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :suggestions, Topic.list_suggestions())}
  end
end
