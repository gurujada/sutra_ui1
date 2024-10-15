defmodule Breadcrumb do
  use Phoenix.Component

  attr :link_class, :string, default: ""
  attr :class, :string, default: ""
  attr :separator, :string, default: "arrow", values: ["arrow", "slash"]
  attr :links, :list, required: true

  attr :rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target multipart),
    doc: "the arbitrary HTML attributes to apply to the form tag"

  def breadcrumb(assigns) do
    ~H"""
    <ol class={"flex items-center whitespace-nowrap #{@class}"}>
      <%= for {link, index} <- Enum.with_index(@links) do %>
        <%= if index > 0, do: separator(assigns) %>
        <li class="inline-flex items-center">
          <.link
            class={"flex items-center text-sm text-gray-500 focus:outline-none dark:text-neutral-500 #{if length(@links) == index + 1, do: ending_class(), else: "hover:text-blue-600 dark:hover:text-blue-500 focus:text-blue-500"} #{@link_class}"}
            patch={link.to}
            {@rest}
          >
            <LibraryWeb.CoreComponents.icon
              :if={Map.has_key?(link, :icon)}
              name={link.icon}
              class="shrink-0 me-1 h-5 w-5"
            />
            <%= link.label %>
          </.link>
        </li>
      <% end %>
    </ol>
    """
  end

  def separator(assigns = %{separator: "slash"}) do
    ~H"""
    <svg
      class="inline-flex flex-shrink-0 h-5 w-5 mx-2 text-gray-400 stroke-current dark:text-gray-600"
      viewBox="0 0 16 16"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      aria-hidden="true"
    >
      <path d="M6 13L10 3" stroke="currentColor" stroke-linecap="round" />
    </svg>
    """
  end

  def separator(assigns = %{separator: "arrow"}) do
    ~H"""
    <svg
      class="inline-flex flex-shrink-0 h-5 w-5 mx-2 text-gray-400 stroke-current dark:text-gray-600"
      xmlns="http://www.w3.org/2000/svg"
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
  end

  def ending_class() do
    "inline-flex items-center text-sm
    font-semibold text-gray-800 truncate dark:!text-neutral-200 cursor-default"
  end
end
