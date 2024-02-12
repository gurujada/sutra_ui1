defmodule Breadcrumb do
  use Phoenix.Component

  attr :separator, :string, default: "arrow", values: ["arrow", "slash"]

  attr :link_class, :string, default: ""

  attr :class, :string, default: ""

  attr :link_type, :string, default: "live_patch", values: ["live_patch", "live_redirect", "a"]

  def breadcrumb(assigns) do
    ~H"""
    <div class={@class}>
      <%= for {link, counter} <- Enum.with_index(@links) do %>
        <%= if counter > 0 do %>
          <.separator separator={@separator} />
        <% end %>
        <Link.linkv
          to={link.to}
          class={"#{get_link_classes(assigns)} #{ending_class(assigns, link)} "}
          link_type={Map.get(link, :link_type, "live_patch")}
        >
          <%= link.label %>
        </Link.linkv>

        <%!-- <Link.a to={link.to} class={@link_class}>
          <div class="flex items-center gap-2">
            <%= if link[:icon] do %>
              <Icon.icon name={link[:icon]} class={["pc-breadcrumb-icon", link[:icon_class]]} />
            <% end %>
            <%= if link[:label] do %>
              <%= link.label %>
            <% end %>
          </div>
        </Link.a> --%>
      <% end %>
    </div>
    """
  end

  def get_link_classes(assigns) do
    "select-none inline-flex items-center text-sm text-gray-500 hover:text-blue-600 focus:outline-none focus:text-blue-600 dark:focus:text-blue-500 #{assigns.link_class}"
  end

  def ending_class(assigns, link) do
    if List.last(assigns.links) == link do
      "text-black font-semibold"
    end
  end

  def separator(assigns) do
    case assigns.separator do
      "arrow" ->
        ~H"""
        <svg
          class="inline-flex flex-shrink-0 w-6 h-6 mx-2 text-gray-400 stroke-current ark:text-gray-600"
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
          stroke="currentColor"
          stroke-width="2"
          stroke-linecap="round"
          stroke-linejoin="round"
        >
          <path d="m9 18 6-6-6-6" />
        </svg>
        """

      "slash" ->
        ~H"""
        <svg
          class="inline-flex flex-shrink-0 w-6 h-6 mx-2 text-gray-400 stroke-current ark:text-gray-600"
          viewBox="0 0 16 16"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          aria-hidden="true"
        >
          <path d="M6 13L10 3" stroke="currentColor" stroke-linecap="round" />
        </svg>
        """
    end
  end
end
