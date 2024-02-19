defmodule Offcanvas do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  slot :inner_block
  attr :position, :string, default: "left", values: ["top", "right", "left", "bottom"]

  def offcanvas(%{position: "right"} = assigns) do
    ~H"""
    <button
      class="z-50 bg-red-400"
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "translate-x-full", "-translate-x-0"},
          out: {"ease-in-out duration-300", "-translate-x-0", "translate-x-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
    >
      Open
    </button>
    <div
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "translate-x-full", "-translate-x-0"},
          out: {"ease-in-out duration-300", "-translate-x-0", "translate-x-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
      id="backdrop"
      class="absolute z-10 hidden w-full h-screen bg-gray-600/20"
    >
    </div>
    <div
      id="cart"
      class={[
        "hidden h-screen bg-white lg:max-w-sm max-w-xs top-0 right-0 absolute z-50"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def offcanvas(%{position: "left"} = assigns) do
    ~H"""
    <button
      class="z-50 bg-red-400"
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "-translate-x-full", "translate-x-0"},
          out: {"ease-in-out duration-300", "translate-x-0", "-translate-x-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
    >
      Open
    </button>
    <div
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "-translate-x-full", "translate-x-0"},
          out: {"ease-in-out duration-300", "translate-x-0", "-translate-x-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
      id="backdrop"
      class="absolute z-10 hidden w-full h-screen bg-gray-600/20"
    >
    </div>
    <div
      id="cart"
      class={[
        "hidden h-screen bg-white lg:max-w-sm max-w-xs top-0 left-0 absolute z-50"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def offcanvas(%{position: "top"} = assigns) do
    ~H"""
    <button
      class="z-50 bg-red-400 "
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "-translate-y-full", "translate-y-0"},
          out: {"ease-in-out duration-300", "translate-y-0", "-translate-y-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
    >
      Open
    </button>
    <div
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "-translate-y-full", "translate-y-0"},
          out: {"ease-in-out duration-300", "translate-y-0", "-translate-y-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
      id="backdrop"
      class="absolute inset-x-0 z-10 hidden w-full h-screen bg-gray-600/20"
    >
    </div>
    <div
      id="cart"
      class={[
        "hidden bg-white w-full max-h-min inset-x-0 top-0 absolute z-50"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  def offcanvas(%{position: "bottom"} = assigns) do
    ~H"""
    <button
      class="z-50 bg-red-400 "
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "translate-y-full", "-translate-y-0"},
          out: {"ease-in-out duration-300", "-translate-y-0", "translate-y-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
    >
      Open
    </button>
    <div
      phx-click={
        JS.toggle(
          to: "#cart",
          in: {"ease-in-out duration-300", "translate-y-full", "-translate-y-0"},
          out: {"ease-in-out duration-300", "-translate-y-0", "translate-y-full"},
          time: 300
        )
        |> JS.toggle(
          to: "#backdrop",
          in: "fade-in",
          out: "fade-out"
        )
      }
      id="backdrop"
      class="absolute inset-0 z-10 hidden w-full h-screen bg-gray-600/20"
    >
    </div>
    <div
      id="cart"
      class={[
        "hidden bg-white w-full max-h-min inset-x-0 bottom-0 absolute z-50"
      ]}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
