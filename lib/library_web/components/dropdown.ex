defmodule Dropdown do
  use Phoenix.Component
  slot :content, required: true
  slot :trigger, requirded: true
  attr :class, :string, default: ""

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  def dropdown(assigns) do
    ~H"""
    <div
      id={Ecto.UUID.generate()}
      phx-hook="Dropdown"
      class={"inline-flex relative #{@class}"}
      {@rest}
    >
      <%= render_slot(@trigger) %>
      <div
        class="hidden absolute top-12 w-auto bg-white shadow-md rounded-lg mt-2 ark:bg-neutral-800 ark:border ark:border-neutral-700 ark:divide-neutral-700"
        role="menu"
        aria-orientation="vertical"
      >
        <div class="space-y-0.5">
          <%= render_slot(@content) %>
        </div>
      </div>
    </div>
    """
  end
end
