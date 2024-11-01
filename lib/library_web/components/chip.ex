defmodule Chip do
  import Helpers

  alias Phoenix.LiveView.JS
  use Phoenix.Component
  attr :class, :string, default: ""

  attr :variant, :string,
    default: "solid",
    values: ["solid", "outline", "soft", "white"]

  attr :dismissable, :boolean, default: false
  attr :icon, :map, default: nil, doc: "The icon to be included in the chip"
  attr :rest, :global, doc: "The arbitrary HTML attributes to pass to the component"
  attr :label, :string, default: "", doc: "The label of the chip"

  def chip(assigns) do
    assigns = assign_new(assigns, :internal_id, fn -> "chip-#{Ecto.UUID.generate()}" end)

    ~H"""
    <span id={@internal_id} class={chip_classes(@variant, @class)}>
      <.icon
        :if={@icon && Map.get(@icon, :position, "left") == "left"}
        name={Map.get(@icon, :name, "hero-")}
        class={"shrink-0 size-3 #{Map.get(@icon, :class, "")}"}
      />
      <%= @label %>
      <.icon
        :if={@icon && Map.get(@icon, :position) == "right"}
        name={Map.get(@icon, :name, "hero-")}
        class={"shrink-0 size-3 #{Map.get(@icon, :class, "")}"}
      />
      <span
        :if={@dismissable}
        phx-click={JS.hide(to: "#" <> "#{@internal_id}")}
        class="hover:cursor-pointer hover:bg-red-100 p-0.5 rounded-full"
        aria-label="Dismiss"
      >
        <.icon
          :if={@dismissable}
          name="hero-x-mark"
          class="size-3 text-current opacity-50 hover:opacity-100 focus:outline-none"
        />
      </span>
    </span>
    """
  end

  def chip_classes(variant, class) do
    "inline-flex justify-center items-center gap-x-1.5 py-1.5 px-3 rounded-full text-xs font-medium disabled:opacity-50 disabled:pointer-events-none #{variant(variant)} #{class}"
  end

  defp variant("solid"), do: "bg-blue-600 text-white dark:bg-blue-500"

  defp variant("soft"),
    do: "bg-blue-100 text-blue-800 dark:bg-blue-800/30 dark:text-blue-500"

  defp variant("outline"),
    do: "border border-blue-600 text-blue-600 dark:text-blue-500"

  defp variant("white"),
    do:
      "border border-gray-200 bg-white text-gray-800 shadow-sm dark:bg-neutral-900 dark:border-neutral-700 dark:text-white"
end
