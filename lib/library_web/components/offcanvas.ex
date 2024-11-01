defmodule Offcanvas do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  slot :inner_block
  attr :position, :string, default: "left", values: ["top", "right", "left", "bottom"]
  attr :class, :string, default: ""
  attr :id, :any, required: true, doc: "The unique id of the offcanvas element"
  slot :trigger, required: true, doc: "The trigger element"

  def offcanvas(assigns) do
    ~H"""
    <div class="w-fit" phx-click={toggle(@position, @id)}>
      <%= render_slot(@trigger) %>
    </div>
    <div
      phx-click={toggle(@position, @id)}
      id={"backdrop-#{@id}"}
      class="absolute inset-0 opacity-90 z-40 hidden w-full h-full bg-gray-600/20"
    >
    </div>
    <div
      id={@id}
      class={[
        "absolute hidden transition-transform transform",
        position(@position)
      ]}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp position("left"),
    do: "h-full bg-white z-50 top-0 left-0 lg:max-w-sm max-w-xs -translate-x-full"

  defp position("right"),
    do: "h-full bg-white z-50 top-0 right-0 lg:max-w-sm max-w-xs translate-x-full"

  defp position("top"), do: "bg-white z-50 max-h-min w-full top-0 inset-x-0 -translate-y-full"

  defp position("bottom"),
    do: "bg-white z-50 max-h-min w-full bottom-0 inset-x-0 translate-y-full"

  def toggle("left", id) do
    JS.toggle(
      to: "##{id}",
      in: {"ease-in-out duration-300", "-translate-x-full", "translate-x-0"},
      out: {"ease-in-out duration-300", "translate-x-0", "-translate-x-full"},
      time: 300
    )
    |> toggle_backdrop(id)
  end

  def toggle("right", id) do
    JS.toggle(
      to: "##{id}",
      in: {"ease-in-out duration-300", "translate-x-full", "-translate-x-0"},
      out: {"ease-in-out duration-300", "-translate-x-0", "translate-x-full"},
      time: 300
    )
    |> toggle_backdrop(id)
  end

  def toggle("top", id) do
    JS.toggle(
      to: "##{id}",
      in: {"ease-in-out duration-300", "-translate-y-full", "translate-y-0"},
      out: {"ease-in-out duration-300", "translate-y-0", "-translate-y-full"},
      time: 300
    )
    |> toggle_backdrop(id)
  end

  def toggle("bottom", id) do
    JS.toggle(
      to: "##{id}",
      in: {"ease-in-out duration-300", "translate-y-full", "-translate-y-0"},
      out: {"ease-in-out duration-300", "-translate-y-0", "translate-y-full"},
      time: 300
    )
    |> toggle_backdrop(id)
  end

  def toggle_backdrop(js \\ %JS{}, id),
    do:
      js
      |> JS.toggle(
        to: "#backdrop-#{id}",
        in: "fade-in",
        out: "fade-out"
      )
end
