defmodule Link do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  attr :link_type, :string,
    default: "button",
    values: ["button", "link", "live_patch", "live_redirect"]

  attr :to, :string, default: ""

  slot :icon, required: false
  attr :icon_position, :string, default: "left", values: ["left", "right"]
  attr :class, :string, default: ""

  def linkv(assigns) do
    case assigns[:link_type] do
      "live_patch" ->
        ~H"""
        <.link patch={~p"/#{@to}"} class={@class}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """

      "button" ->
        ~H"""
        <.link class={@class}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """

      "a" ->
        ~H"""
        <.link href={@to} class={@class}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """

      "live_redirect" ->
        ~H"""
        <.link navigate={~p"/#{@to}"} class={@class}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """
    end
  end
end
