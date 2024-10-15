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

  attr :size, :string, default: "sm", values: ["sm", "md", "lg"]
  slot :modal_header, required: true, attrs: [:class]
  slot :modal_content, required: true, attrs: [:class]
  slot :modal_footer, required: false, attrs: [:class]

  def modal(assigns) do
    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      data-cancel={JS.exec(@on_cancel, "phx-remove")}
      class="relative z-50 hidden"
    >
      <div
        id={"#{@id}-bg"}
        class="fixed inset-0 transition-opacity bg-zinc-100/90"
        aria-hidden="true"
      />
      <div
        class="fixed inset-0 overflow-y-auto"
        aria-labelledby={"#{@id}-title"}
        aria-describedby={"#{@id}-description"}
        role="dialog"
        aria-modal="true"
        tabindex="0"
      >
        <div class="flex items-center justify-center min-h-full">
          <div class={"w-full p-2 m-3 #{size_class(assigns)}"}>
            <.focus_wrap
              id={"#{@id}-container"}
              phx-window-keydown={JS.exec("data-cancel", to: "##{@id}")}
              phx-key="escape"
              phx-click-away={JS.exec("data-cancel", to: "##{@id}")}
              class="relative hidden transition duration-500 bg-white shadow-lg shadow-zinc-700/10 ring-zinc-700/10 rounded-2xl ring-1
              flex flex-col border shadow-sm rounded-xl pointer-events-auto dark:bg-gray-800 dark:border-gray-700 dark:shadow-slate-700/[.7]
              "
            >
              <div class="flex items-center justify-between px-4 py-3 border-b dark:border-gray-700">
                <h3 class="font-bold text-gray-800 dark:text-white">
                  <%= render_slot(@modal_header) %>
                </h3>
                <button
                  phx-click={JS.exec("data-cancel", to: "##{@id}")}
                  type="button"
                  class="flex items-center justify-center text-sm font-semibold text-gray-600 border border-transparent rounded-full focus:outline-none size-7 hover:bg-gray-100 disabled:opacity-50 disabled:pointer-events-none dark:text-white dark:hover:bg-gray-700 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"
                >
                  <span class="sr-only">Close</span>
                  <svg
                    class="flex-shrink-0 p-1 size-4"
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
                    <path d="M18 6 6 18" /><path d="m6 6 12 12" />
                  </svg>
                </button>
              </div>
              <div class={[
                "p-4 overflow-y-auto",
                Map.has_key?(hd(@modal_content), :class) && hd(@modal_content).class
              ]}>
                <%= render_slot(@modal_content) %>
              </div>
              <div class={[
                "flex items-center justify-end px-4 py-3 border-t gap-x-2 dark:border-gray-700",
                Map.has_key?(hd(@modal_footer), :class) && hd(@modal_footer).class
              ]}>
                <%= render_slot(@modal_footer) %>
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

  def size_class(assigns) do
    case assigns.size do
      "sm" -> "sm:max-w-lg sm:w-full sm:mx-auto"
      "md" -> "md:max-w-2xl md:w-full md:mx-auto"
      "lg" -> "lg:max-w-4xl lg:w-full lg:mx-auto"
    end
  end
end
