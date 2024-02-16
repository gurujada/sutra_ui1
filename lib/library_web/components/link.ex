defmodule Link do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  attr :link_type, :string,
    default: "button",
    values: ["button", "link", "live_patch", "navigate"]

  attr :to, :string, default: ""

  slot :icon, required: false
  attr :icon_position, :string, default: "left", values: ["left", "right"]
  attr :class, :string, default: ""

  def linkv(%{link_type: "a"} = assigns) do
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
  end

  def linkv(%{link_type: "live_patch"} = assigns) do
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
  end

  def linkv(%{link_type: "button"} = assigns) do
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
  end

  def linkv(%{link_type: "navigate"} = assigns) do
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
