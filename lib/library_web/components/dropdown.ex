defmodule Dropdown do
  use Phoenix.Component
  slot :content, required: true
  slot :trigger, required: true
  attr :class, :string, default: ""

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  def dropdown(assigns) do
    ~H"""
    <div
      id={Ecto.UUID.generate()}
      phx-hook="Dropdown"
      class={"relative inline-flex #{@class}"}
      {@rest}
    >
      <%= render_slot(@trigger) %>
      <div
        class="z-50 duration hidden min-w-60 bg-white shadow-md rounded-lg mt-2 divide-y divide-gray-200 dark:bg-neutral-800 dark:border dark:border-neutral-700 dark:divide-neutral-700"
        role="menu"
        aria-orientation="vertical"
        aria-labelledby="hs-dropdown-with-dividers"
      >
        <%= render_slot(@content) %>
        <%!-- Wrap your content in <div class="p-1 space-y-0.5"> to get neatly spaced divides.
        Else, wrap entire content in one div with same class to get neatly spaced items. --%>
      </div>
    </div>
    """
  end
end
