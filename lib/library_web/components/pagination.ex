defmodule Pagination do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  attr :variant, :string, default: "numbered", values: ["numbered", "lettered"]
  attr :options, :map
  attr :changeset, :string

  def pagination(%{variant: "lettered"} = assigns) do
    ~H"""
    <LibraryWeb.Button.button size="sm" color="primary">
      <.link navigate={~p"/#{@changeset}?#{%{@options | page: @options.page + 1}}"}>
        Next
      </.link>
    </LibraryWeb.Button.button>
    <LibraryWeb.Button.button :if={@options.page > 1} size="sm" color="primary">
      <.link navigate={~p"/#{@changeset}?#{%{@options | page: @options.page - 1}}"}>
        Previous
      </.link>
    </LibraryWeb.Button.button>
    """
  end
end
