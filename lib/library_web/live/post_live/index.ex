defmodule LibraryWeb.PostLive.Index do
  use LibraryWeb, :live_view
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  alias Library.Timeline
  alias Library.Timeline.Post
  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> put_flash(:info, "Mounted Successfully")

    {:ok, stream(socket, :posts, Timeline.list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    socket =
      socket
      |> assign(active_tab: params["tab"] || "home")
      |> apply_action(socket.assigns.live_action, params)

    {:noreply, socket}
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

  def handle_event("toggle", _, socket) do
    socket = socket |> update(:show_cart, fn show -> !show end)
    {:noreply, socket}
  end
end
