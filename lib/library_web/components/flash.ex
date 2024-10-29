defmodule Flash do
  use Phoenix.Component
  attr(:id, :string, doc: "the optional id of flash container")
  attr(:flash, :map, default: %{}, doc: "the map of flash messages to display")
  attr(:title, :string, default: nil)
  attr(:kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup")
  attr(:rest, :global, doc: "the arbitrary HTML attributes to add to the flash container")
  attr(:target, :any, default: nil, doc: "the target for the phx-click event")

  attr(:duration, :integer,
    default: 6000,
    doc: "the time in milliseconds before the message is automatically dismissed"
  )

  attr(:toast_class_fn, :any,
    required: true,
    doc: "function to override the toast classes"
  )

  attr(:corner, :atom, required: true, doc: "the corner to display the toasts")

  attr(:icon, :any, default: nil, doc: "the optional icon to render in the flash message")
  attr(:action, :any, default: nil, doc: "the optional action to render in the flash message")
  attr(:component, :any, default: nil, doc: "the optional component to render the flash message")

  slot(:inner_block, doc: "the optional inner block that renders the flash message")


  def flash(assigns) do
    assigns =
      assign_new(assigns, :id, fn -> "flash-#{assigns.kind}" end)

    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      role="alert"
      phx-hook="LiveToast"
      data-duration={@duration}
      data-corner={@corner}
      class={@toast_class_fn.(assigns)}
      {@rest}
    >
      <%= if @component do %>
        <%= @component.(Map.merge(assigns, %{body: msg})) %>
      <% else %>
        <div class="grow flex flex-col items-start justify-center">
          <p
            :if={@title}
            data-part="title"
            class={[
              if(@icon, do: "mb-2", else: ""),
              "flex items-center text-sm font-semibold leading-6"
            ]}
          >
            <%= if @icon do %>
              <%= @icon.(assigns) %>
            <% end %>
            <%= @title %>
          </p>
          <p class="text-sm leading-5">
            <%= msg %>
          </p>
        </div>

        <%= if @action do %>
          <%= @action.(assigns) %>
        <% end %>
      <% end %>
      <button
        type="button"
        class={[
          "group-has-[[data-part='title']]/toast:absolute",
          "right-[5px] top-[5px] rounded-md p-[5px] text-black/50 transition-opacity hover:text-black focus:opacity-100 focus:outline-none focus:ring-1 group group-hover:opacity-100"
        ]}
        aria-label="close"
        {
        if Phoenix.Flash.get(@flash, @kind),
          do: ["phx-click": JS.dispatch("flash-leave", to: "##{@id}") |> JS.push("lv:clear-flash", value: %{key: @kind})],
          else: [
            "phx-target": @target,
            "phx-click": "clear",
            "phx-value-id": @id
          ]
        }
      >
        <%!-- <Utility.svg
          name="hero-x-mark-solid"
          class="h-[14px] w-[14px] opacity-40 group-hover:opacity-70"
        /> --%>
      </button>
    </div>
    """

  end


end
