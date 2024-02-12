defmodule Chip do
  use Phoenix.Component

  attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]

  attr :radius, :string, default: "full", values: ["xs", "sm", "md", "lg", "xl", "full"]

  attr :class, :string, default: ""

  attr :color, :string,
    default: "default",
    values: ["primary", "secondary", "success", "warning", "danger", "default"]

  attr :variant, :string,
    default: "solid",
    values: ["solid", "faded", "bordered", "light", "flat", "ghost", "shadow"]

  attr :disabled, :boolean, default: false

  attr :indicator, :boolean, default: false
  attr :icon_position, :string, default: "left", values: ["left", "right"]
  slot :icon, required: false

  def chip(assigns) do
    ~H"""
    <span class={get_chip_classes(assigns)}>
      <span :if={@indicator} class="relative inline-flex w-1.5 h-1.5 rounded-full bg-amber-500">
      </span>
      <%= if @icon_position == "left" && @icon do %>
        <%= render_slot(@icon) %>
        <%= render_slot(@inner_block) %>
      <% end %>
      <%= if @icon_position == "right" && @icon do %>
        <%= render_slot(@inner_block) %>
        <%= render_slot(@icon) %>
      <% end %>
      <%= if !@icon do %>
        <%= render_slot(@icon) %>
      <% end %>
    </span>
    """
  end

  def get_chip_classes(assigns) do
    "inline-flex justify-center disabled:opacity-50 disabled:pointer-events-none items-center gap-x-1.5 font-medium #{size_classes(assigns[:size])} #{radius_classes(assigns[:radius])} #{color_and_variant_classes(assigns.color, assigns[:variant])} #{assigns[:class]}"
  end

  def size_classes(size) do
    case size do
      "xs" -> "text-xs leading-4 px-2.5 py-1"
      "sm" -> "px-3 py-1 text-sm leading-4"
      "md" -> "px-3 py-1 text-md leading-5"
      "lg" -> "px-4 py-1 text-lg leading-6"
    end
  end

  def radius_classes(radius) do
    case radius do
      "xs" -> "rounded-xs"
      "sm" -> "rounded-sm"
      "md" -> "rounded-md"
      "lg" -> "rounded-lg"
      "full" -> "rounded-full"
      "none" -> "rounded-none"
    end
  end

  def color_and_variant_classes(color, variant) do
    case color do
      "primary" ->
        case variant do
          "solid" ->
            "bg-gray-800 text-white dark:bg-white dark:text-gray-800"

          "outline" ->
            "text-gray-500 dark:border-gray-700 dark:text-gray-400   dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-blue-100 text-blue-800 hover:bg-blue-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-primary hover:bg-blue-100 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-primary shadow-lg hover:bg-blue-400 shadow-primary"
        end

      "secondary" ->
        case variant do
          "solid" ->
            "bg-secondary text-white hover:bg-purple-800"

          "outline" ->
            "text-gray-500 hover:border-secondary hover:text-secondary dark:border-gray-700 dark:text-gray-400 dark:hover:text-secondary dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-blue-100 text-blue-800 hover:bg-blue-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-secondary hover:bg-blue-100 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-secondary shadow-lg hover:bg-blue-400 shadow-secondary"
        end

      "success" ->
        case variant do
          "solid" ->
            "text-white bg-success hover:bg-green-600"

          "outline" ->
            "text-gray-500 hover:border-success hover:text-success dark:border-gray-700 dark:text-gray-400 dark:hover:text-success dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-blue-100 text-blue-800 hover:bg-blue-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-success hover:bg-blue-100 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-success shadow-lg hover:bg-green-400 shadow-success"
        end

      "warning" ->
        case variant do
          "solid" ->
            "text-white bg-warning hover:bg-yellow-600"

          "outline" ->
            "text-gray-500 hover:border-warning hover:text-warning dark:border-gray-700 dark:text-gray-400 dark:hover:text-warning dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-blue-100 text-blue-800 hover:bg-blue-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-warning hover:bg-blue-100 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-warning shadow-lg hover:bg-blue-400 shadow-warning"
        end

      "danger" ->
        case variant do
          "solid" ->
            "text-white bg-danger hover:bg-red-600"

          "outline" ->
            "text-gray-500 hover:border-danger hover:text-danger dark:border-gray-700 dark:text-gray-400 dark:hover:text-danger dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-blue-100 text-blue-800 hover:bg-blue-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-danger hover:bg-blue-100 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-danger shadow-lg hover:bg-blue-400 shadow-danger"
        end

      "default" ->
        case variant do
          "solid" ->
            "text-white bg-gray-300 hover:bg-blue-700"

          "outline" ->
            "text-gray-500 hover:border-gray-300 hover:text-gray-300 dark:border-gray-700 dark:text-gray-400 dark:hover:text-default dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-blue-100 text-blue-800 hover:bg-blue-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-800 shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-gray-300 hover:bg-blue-100 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-gray-300 shadow-lg hover:bg-blue-400 shadow-primary"
        end
    end
  end
end
