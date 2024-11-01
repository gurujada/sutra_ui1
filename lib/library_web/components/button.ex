defmodule Button do
  use Phoenix.Component
  import Helpers
  attr :class, :string, default: ""
  attr :size, :string, default: "md", values: ["sm", "md", "lg"]

  attr :variant, :string,
    default: "solid",
    values: ["solid", "outline", "soft", "white", "ghost", "shadow"]

  slot :inner_block, required: true
  attr :icon, :map, default: nil, doc: "the icon & icon params to display"
  attr :icon_position, :string, default: "left", values: ["left", "right"]
  attr :rest, :global, doc: "the arbitrary HTML attributes to apply"

  def button(assigns) do
    ~H"""
    <.link class={button_classes(@size, @variant, @class)} {@rest}>
      <.icon
        :if={@icon && Map.get(@icon, :position, "left") == "left"}
        name={@icon.name}
        class={"#{icon_size(@size)} shrink-0 #{Map.get(@icon, :class, "")}"}
      />
      <%= render_slot(@inner_block) %>
      <.icon
        :if={@icon && Map.get(@icon, :position) == "right"}
        name={@icon.name}
        class={"#{icon_size(@size)} shrink-0 #{Map.get(@icon, :class, "")}"}
      />
    </.link>
    """
  end

  defp button_classes(size, variant, class) do
    # Include in the documentation that rounded-sm will superseed the rounded-full class
    "inline-flex items-center gap-x-2 text-sm font-medium rounded-lg disabled:opacity-50 disabled:pointer-events-none #{size_classes(size)} #{variant_class(variant)} #{class}"
  end

  defp size_classes("sm"), do: "py-2 px-3"
  defp size_classes("md"), do: "py-3 px-4"
  defp size_classes("lg"), do: "p-4 sm:p-5"

  defp icon_size("sm"), do: "size-3"
  defp icon_size("md"), do: "size-4"
  defp icon_size("lg"), do: "size-5"

  defp variant_class("solid"),
    do: "border border-transparent bg-blue-600 text-white hover:bg-blue-700
  focus:outline-none focus:bg-blue-700"

  defp variant_class("outline"),
    do:
      "border border-blue-600 text-blue-600 hover:border-blue-500 hover:text-blue-500 focus:outline-none focus:border-blue-500 focus:text-blue-500 dark:border-blue-500 dark:text-blue-500 dark:hover:text-blue-400 dark:hover:border-blue-400"

  defp variant_class("ghost"),
    do:
      "border border-transparent text-blue-600 hover:bg-blue-100 focus:outline-none
    focus:bg-blue-100 hover:text-blue-800 focus:outline-none focus:bg-blue-100 focus:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:bg-blue-800/30 dark:focus:text-blue-400"

  defp variant_class("soft"),
    do:
      "bg-blue-100 text-blue-800 hover:bg-blue-200 focus:outline-none focus:bg-blue-200 dark:text-blue-400 dark:bg-blue-800/30 dark:hover:bg-blue-800/20 dark:focus:bg-blue-800/20"

  defp variant_class("white"),
    do:
      "bg-white text-blue-600 shadow-sm hover:bg-gray-50 focus:outline-none focus:bg-gray-50 dark:bg-neutral-800 dark:border-neutral-700 dark:hover:bg-neutral-700 dark:focus:bg-neutral-700 dark:text-blue-500"

  defp variant_class("shadow"),
    do: "bg-blue-800 shadow-md shadow-blue-800/50 hover:shadow-lg text-white"
end
