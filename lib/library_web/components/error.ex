defmodule Error do
  use Phoenix.Component
slot :inner_block, required: true

  def error(assigns) do
    ~H"""
    <p class="flex gap-3 mt-3 text-sm leading-6 text-rose-600 phx-no-feedback:hidden">
      <LibraryWeb.CoreComponents.icon name="hero-exclamation-circle-mini" class="mt-0.5 h-5 w-5 flex-none" />
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

end
