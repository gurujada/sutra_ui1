defmodule LibraryWeb.PostLive.Index do
  use LibraryWeb, :live_view

  alias Library.Timeline
  alias Library.Timeline.Post

  import Ecto.Query

  @impl true
  def mount(params, _session, socket) do
    socket =
      socket
      |> assign(:query, from(p in Post))
      |> assign(:params, params)
      |> assign(:cols,
        id: %{},
        body: %{function: "String.capitalize()"},
        likes_count: %{},
        photo_locations: %{default: "-"}
      )
      |> assign(filter: %{type: "", value: ""})

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()
    page = (params["page"] || "1") |> String.to_integer()
    per_page = (params["per_page"] || "5") |> String.to_integer()

    options = %{sort_by: sort_by, sort_order: sort_order, page: page, per_page: per_page}

    socket =
      socket
      |> assign(options: options)
      |> stream(
        :rows,
        LibraryWeb.PostLive.LiveTable.get_records_by_query(socket.assigns.query, options, socket.assigns.filter)
      )

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
    {:noreply, stream_insert(socket, :rows, post)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, stream_delete(socket, :posts, post)}
  end

  def handle_event("filter", %{"type" => type, "value" => value}, socket) do
    filter = %{type: type, value: value}
      {:noreply, stream(socket, :rows, LibraryWeb.PostLive.LiveTable.get_records_by_query(@query, @options, filter))}
  end

  def filter_options() do
    [
      All: "",
      Contains: "contains",
      Equals: "equals",
      "Starts With": "starts",
      "Ends With": "ends"
    ]
  end
end
