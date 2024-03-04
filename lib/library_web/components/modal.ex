defmodule Modal do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  #   attr :class, :string, default: ""
  #   attr :id, :string, default: ""
  #   attr :show, :boolean, default: true
  #   slot :inner_block, required: false
  #   attr :close_modal_target, :string,    default: nil
  #   attr :close_on_click_away, :boolean,    default: true

  #   attr :close_on_escape, :boolean,    default: true

  #   attr :hide_close_button, :boolean,    default: false

  #   attr :rest, :global

  # def modal(assigns) do
  #   ~H"""
  #     <div id={@id} phx-mounted={@show && show_modal(@id)}

  #     >
  #     <%= render_slot(@inner_block) %>
  #     </div>

  #   """
  # end

  # def show_modal(js \\ %JS{}, id) do
  #     js
  #     |> JS.show(to: "##{id}")
  #     |> JS.show(
  #       to: "##{id} bg-red-200",
  #       transition: {"transition-all transform ease-out duration-300", "opacity-0", "opacity-100"}
  #     )
  #     |> JS.show(
  #       to: "##{id} bg-teal-200",
  #       transition:
  #         {"transition-all transform ease-out duration-300",
  #          "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
  #          "opacity-100 translate-y-0 sm:scale-100"}
  #     )
  #     |> JS.add_class("overflow-hidden", to: "body")
  #     |> JS.focus_first(to: "##{id} .pc-modal__box")
  #   end

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      data-cancel={JS.exec(@on_cancel, "phx-remove")}
      class="relative z-50 hidden"
    >
      <div id={"#{@id}-bg"} class="fixed inset-0 transition-opacity bg-zinc-100/90" aria-hidden="true" />
      <div
        class="fixed inset-0 overflow-y-auto"
        aria-labelledby={"#{@id}-title"}
        aria-describedby={"#{@id}-description"}
        role="dialog"
        aria-modal="true"
        tabindex="0"
      >
        <div class="flex items-center justify-center min-h-full">
          <div class="w-full max-w-3xl p-2 sm:max-w-lg sm:w-full sm:mx-autos">
            <.focus_wrap
              id={"#{@id}-container"}
              phx-window-keydown={JS.exec("data-cancel", to: "##{@id}")}
              phx-key="escape"
              phx-click-away={JS.exec("data-cancel", to: "##{@id}")}
              class="relative hidden transition duration-500 bg-white shadow-lg shadow-zinc-700/10 ring-zinc-700/10 rounded-2xl ring-1
              flex flex-col border shadow-sm rounded-xl pointer-events-auto ark:bg-gray-800 ark:border-gray-700 ark:shadow-slate-700/[.7] p-3
              "
            >


              <div id={"#{@id}-content"}>
              <div class="flex items-center justify-between">
                <%= render_slot(@title_slot) %>
                <div class="absolute top-6 right-5">
                <button
                  phx-click={JS.exec("data-cancel", to: "##{@id}")}
                  type="button"
                  class="flex-none p-3 -m-3 focus:outline-none opacity-20 hover:opacity-40"
                >
                  <.icon name="hero-x-mark-solid" class="w-5 h-5" />
                </button>
              </div>
              </div>
                <%= render_slot(@inner_block) %>

              </div>


            </.focus_wrap>


          </div>
        </div>
      </div>
    </div>
    """
  end

  def show_modal(js \\ %JS{}, id) when is_binary(id) do
    js
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> show("##{id}-container")
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id}-content")
  end

  def hide_modal(js \\ %JS{}, id) do
    js
    |> JS.hide(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> hide("##{id}-container")
    |> JS.hide(to: "##{id}", transition: {"block", "block", "hidden"})
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end

  attr :name, :string, required: true
  attr :class, :string, default: nil

  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end
end
