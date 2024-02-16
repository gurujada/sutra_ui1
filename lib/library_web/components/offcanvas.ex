defmodule Offcanvas do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def offcanvas(assigns) do
    ~H"""
    <h1>Hi!</h1>
    """
  end

  def toggle_cart do
    JS.toggle(
      to: "#cart",
      in: {
        "ease-in-out duration-300",
        "translate-x-full",
        "translate-x-0"
      },
      out: {
        "ease-in-out duration-300",
        "translate-x-0",
        "translate-x-full"
      },
      time: 300
    )
    |> JS.toggle(
      to: "#backdrop",
      in: "fade-in",
      out: "fade-out"
    )
  end
end
