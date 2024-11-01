defmodule DropdownItem do
  use Phoenix.Component
  import Helpers
  attr :class, :string, default: ""
  attr :label, :string, required: true

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  attr :type, :string, values: ["custom", "title", "default"], default: "default"

  attr :icon, :string, default: "hero-"
  attr :kbd, :string, default: ""
  slot :inner_block

  def(dropdownItem(assigns = %{type: "title"})) do
    ~H"""
    <span
      class="block pt-2 pb-1 px-3 text-xs font-medium uppercase text-gray-400 dark:text-neutral-500"
      {@rest}
    >
      <%= @label %>
    </span>
    """
  end

  def dropdownItem(assigns = %{type: "custom"}) do
    ~H"""
    <div class="py-3 px-4 border-b border-gray-200 dark:border-neutral-700" {@rest}>
      <%= render_slot(@inner_block) %>
      <p class="text-sm text-gray-500 dark:text-neutral-400">Signed in as</p>
      <p class="text-sm font-medium text-gray-800 dark:text-neutral-300">james@site.com</p>
    </div>
    """
  end

  def dropdownItem(assigns) do
    ~H"""
    <.link
      class={"flex items-center justify-between gap-x-8 py-2 px-3 rounded-lg text-sm text-gray-700 hover:bg-gray-100 focus:outline-none focus:bg-gray-100 dark:text-neutral-400 dark:hover:bg-neutral-700 dark:hover:text-neutral-300 dark:focus:bg-neutral-700 #{@class}"}
      {@rest}
    >
      <div>
        <.icon :if={@icon} name={@icon} class="shrink-0 h-4 w-4 mr-2 m-1" />
        <%= @label %>
      </div>
      <kbd
        :if={@kbd != ""}
        class="inline-flex justify-center items-center px-1 py-0.5 bg-gray-100 border border-transparent font-mono text-xs text-gray-500 rounded-md dark:bg-neutral-700 dark:text-neutral-400"
      >
        <%= @kbd %>
      </kbd>
    </.link>
    """
  end
end
