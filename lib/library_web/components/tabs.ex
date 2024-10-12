defmodule Tabs do
  use LibraryWeb, :live_component

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  attr :active_tab, :string, required: true
  attr :type, :string, default: "default", values: ["default", "vertical", "card", "segment"]

  slot :tab, required: true do
    attr :icon, :string
    attr :badge, :string
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="border-b border-gray-200 ark:border-neutral-700">
        <nav class="flex gap-x-1" aria-label="Tabs" role="tablist" aria-orientation="horizontal">
          <%= for tab <- @tab do %>
            <.link
              patch={~p"/posts/#{slugify(tab.name)}"}
              type="button"
              class={"group py-4 px-1 inline-flex items-center gap-x-2 border-b-2 border-transparent text-sm whitespace-nowrap hover:text-blue-600 focus:outline-none focus:text-blue-600 disabled:opacity-50 disabled:pointer-events-none ark:text-neutral-400 ark:hover:text-blue-500 #{if (@active_tab == slugify(tab.name)), do: get_active_classes()}"}
              aria-selected="true"
              data-hs-tab="#tabs-with-underline-1"
              aria-controls="tabs-with-underline-1"
              role="tab"
            >
              <%= if tab[:icon] && tab.icon != "" do %>
                <LibraryWeb.CoreComponents.icon
                  name={tab.icon}
                  class={"shrink-0 h-4 w-4 text-gray-600 group-hover:text-blue-600 -mr-1 #{if (@active_tab == slugify(tab.name)), do: get_active_classes()}"}
                />
              <% end %>
              <%= tab.name %>
              <%= if tab[:badge] && tab.badge != "" do %>
                <span class={"bg-gray-100 text-gray-800 ms-1 py-0.5 px-1.5 rounded-full text-xs font-medium ark:bg-neutral-700 ark:text-neutral-300 #{if (@active_tab == slugify(tab.name)), do: get_active_badge()}"}>
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
    "font-semibold border-blue-600 text-blue-600"
  end

  def get_active_badge() do
    "!bg-blue-100 !text-blue-600 !ark:bg-blue-800 !ark:text-white"
  end
end
