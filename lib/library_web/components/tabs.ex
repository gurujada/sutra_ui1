defmodule Tabs do
  use LibraryWeb, :live_component
  # Add @rest
  attr :active_tab, :string, required: true
  attr :type, :string, default: "default", values: ["default", "vertical", "card", "segment"]
  attr :class, :string, default: ""

  slot :tab, required: true do
    attr :icon, :string
    attr :badge, :string
  end

  def render(assigns) do
    ~H"""
    <div class={@class}>
      <div class="border-b border-gray-200 dark:border-neutral-700">
        <nav class="flex gap-x-1" aria-label="Tabs" role="tablist" aria-orientation="horizontal">
          <%= for tab <- @tab do %>
            <.link
              patch={~p"/posts/#{slugify(tab.name)}"}
              type="button"
              class={"group py-4 px-1 inline-flex items-center gap-x-2 border-b-2 border-transparent text-sm whitespace-nowrap
              hover:text-blue-500 focus:outline-none focus:text-blue-500 disabled:opacity-50 disabled:pointer-events-none
              dark:text-neutral-400 dark:hover:text-blue-500 #{if (@active_tab == slugify(tab.name)), do: get_active_classes()}"}
              aria-selected="true"
              data-hs-tab="#tabs-with-underline-1"
              aria-controls="tabs-with-underline-1"
              role="tab"
            >
              <%= if tab[:icon] && tab.icon != "" do %>
                <LibraryWeb.CoreComponents.icon
                  name={tab.icon}
                  class={"shrink-0 h-5 w-5 text-gray-600 group-hover:text-blue-500 -mr-1 #{if (@active_tab == slugify(tab.name)), do: get_active_classes()}"}
                />
              <% end %>
              <%= tab.name %>
              <%= if tab[:badge] && tab.badge != "" do %>
                <span class={"
                ms-1 py-0.5 px-1.5 rounded-full
                text-xs font-medium
                bg-gray-100 text-gray-800 dark:bg-neutral-700 dark:text-neutral-300
                #{if (@active_tab == slugify(tab.name)), do: get_active_badge()}"}>
                  <%= tab.badge %>
                </span>
              <% end %>
            </.link>
          <% end %>
        </nav>
      </div>

      <div class="mt-3">
        <%= Enum.find(@tab, fn tab -> slugify(tab.name) == @active_tab end) |> render_slot() %>
      </div>
    </div>
    """
  end

  def slugify(string) do
    string |> String.replace(" ", "-") |> String.downcase()
  end

  def get_active_classes() do
    "font-semibold !border-blue-500 !text-blue-500"
  end

  def get_active_badge() do
    "!bg-blue-100 !text-blue-600 dark:!bg-blue-800 dark:!text-white"
  end
end
