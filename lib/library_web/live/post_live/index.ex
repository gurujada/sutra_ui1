defmodule LibraryWeb.PostLive.Index do
  use LibraryWeb, :live_view

  alias Library.Timeline
  alias Library.Timeline.Post

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(show_cart: false)

    {:ok, stream(socket, :posts, Timeline.list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket |> assign(:page_title, "Edit Post") |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket |> assign(:page_title, "New Post") |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket |> assign(:page_title, "Listing Posts") |> assign(:post, nil)
  end

  @impl true
  def handle_info({LibraryWeb.PostLive.FormComponent, {:saved, post}}, socket) do
    {:noreply, stream_insert(socket, :posts, post)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, stream_delete(socket, :posts, post)}
  end
end
