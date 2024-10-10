defmodule DropdownItem do
  use Phoenix.Component

  attr :class, :string, default: ""
  attr :label, :string, required: true

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  attr :type, :string, values: ["custom", "title", "default"], default: "default"

  attr :icon, :string, default: "hero-"

  def(dropdownItem(assigns = %{type: "title"})) do
    ~H"""
    <span
      class="block pt-2 pb-1 px-3 text-xs font-medium uppercase text-gray-400 ark:text-neutral-500"
      {@rest}
    >
      <%= @label %>
    </span>
    """
  end

  def dropdownItem(assigns = %{type: "custom"}) do
    ~H"""
    <div class="py-3 px-4 border-b border-gray-200 ark:border-neutral-700" {@rest}>
      <%= render_slot(@inner_block) %>
      <p class="text-sm text-gray-500 ark:text-neutral-400">Signed in as</p>
      <p class="text-sm font-medium text-gray-800 ark:text-neutral-300">james@site.com</p>
    </div>
    """
  end

  def dropdownItem(assigns) do
    ~H"""
    <.link
      class={"flex items-center py-2 px-3 rounded-lg text-sm text-gray-700 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 ark:text-neutral-400 ark:hover:bg-neutral-700 ark:hover:text-neutral-300 ark:focus:bg-neutral-700 #{@class}"}
      {@rest}
    >
      <LibraryWeb.CoreComponents.icon :if={@icon} name={@icon} class="shrink-0 h-4 w-4 mr-2 m-1" />
      <%= @label %>
    </.link>
    """
  end
end
