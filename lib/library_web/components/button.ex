defmodule Button do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  attr :class, :string, default: ""

  attr :rest, :global, include: ~w(disabled form name value)

  attr :color, :string,
    default: "default",
    values: ["primary", "secondary", "success", "warning", "danger", "default"]

  attr :size, :string, default: "md", values: ["sm", "md", "lg"]

  attr :radius, :string, default: "lg", values: ["xs", "sm", "md", "lg", "xl", "full"]

  attr :variant, :string,
    default: "solid",
    values: ["solid", "outline", "soft", "white", "ghost", "shadow"]

  attr :link_type, :string,
    default: "button",
    values: ["button", "live_patch", "navigate", "a"]

  attr :to, :string, default: ""

  slot(:inner_block, required: true)

  attr :icon_position, :string, default: "left", values: ["left", "right"]
  slot :icon, required: false
  attr :type, :string, default: nil

  def button(assigns) do
    case assigns[:link_type] do
      "live_patch" ->
        ~H"""
        <.link patch={~p"/#{@to}"} class={get_button_classes(assigns)}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """

      "button" ->
        ~H"""
        <button type={@type} class={[get_button_classes(assigns)]} {@rest}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </button>
        """

      "a" ->
        ~H"""
        <.link href={@to} class={get_button_classes(assigns)}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """

      "navigate" ->
        ~H"""
        <.link navigate={~p"/#{@to}"} class={get_button_classes(assigns)}>
          <%= if @icon && @icon_position == "left" do %>
            <%= render_slot(@icon) %>
          <% end %>
          <%= render_slot(@inner_block) %>
          <%= if @icon && @icon_position == "right" do %>
            <%= render_slot(@icon) %>
          <% end %>
        </.link>
        """
    end
  end

  defp get_button_classes(assigns) do
    # Include in the documentation that rounded-sm will superseed the rounded-full class
    "justify-center items-center inline-flex font-semibold disabled:opacity-50 disabled:pointer-events-none #{size_classes(assigns.size)} #{radius_classes(assigns.radius)} #{color_and_variant_classes(assigns.color, assigns.variant)} #{assigns.class}"
  end

  def color_and_variant_classes(color, variant) do
    case color do
      "primary" ->
        case variant do
          "solid" ->
            "bg-primary/90 text-white hover:bg-primary dark:bg-white dark:text-gray-800"

          "outline" ->
            "text-gray-500 border border-gray-300 hover:border-primary hover:text-primary dark:border-gray-700 dark:text-gray-400 dark:hover:text-primary dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-primary/25 text-primary hover:bg-primary/40 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-300 bg-white text-primary shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-primary hover:bg-primary/40 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-primary shadow-md shadow-primary hover:shadow-primary hover:shadow-lg text-white"
        end

      "secondary" ->
        case variant do
          "solid" ->
            "bg-secondary/90 text-white hover:bg-secondary dark:bg-white dark:text-gray-800"

          "outline" ->
            "text-gray-500 border border-gray-300 hover:border-secondary hover:text-secondary dark:border-gray-700 dark:text-gray-400 dark:hover:text-primary dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-secondary/25 text-secondary hover:bg-secondary/40 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-300 bg-white text-secondary shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-secondary hover:bg-secondary/40 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-secondary shadow-md shadow-secondary hover:shadow-secondary hover:shadow-lg text-white"
        end

      "success" ->
        case variant do
          "solid" ->
            "text-white bg-success hover:bg-green-600"

          "outline" ->
            "text-gray-500 border border-gray-300 hover:border-success hover:text-success dark:border-gray-700 dark:text-gray-400 dark:hover:text-primary dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-success/25 text-success hover:bg-success/40 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-300 bg-white text-success shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-success hover:bg-success/40 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-success shadow-md shadow-success hover:shadow-success hover:shadow-lg text-white"
        end

      "warning" ->
        case variant do
          "solid" ->
            "text-white bg-warning hover:bg-yellow-600"

          "outline" ->
            "text-gray-500 border border-gray-300 hover:border-warning hover:text-warning dark:border-gray-700 dark:text-gray-400 dark:hover:text-primary dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-warning/25 text-warning hover:bg-warning/40 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-300 bg-white text-warning shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-warning hover:bg-warning/40 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-warning shadow-md shadow-warning hover:shadow-warning hover:shadow-lg text-white"
        end

      "danger" ->
        case variant do
          "solid" ->
            "text-white bg-danger hover:bg-red-600"

          "outline" ->
            "text-gray-500 border border-gray-300 hover:border-danger hover:text-danger dark:border-gray-700 dark:text-gray-400 dark:hover:text-primary dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "bg-danger/25 text-danger hover:bg-danger/40 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-300 bg-white text-danger shadow-sm hover:bg-gray-50 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-danger hover:bg-danger/40 hover:text-blue-800 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-danger shadow-md shadow-danger hover:shadow-danger hover:shadow-lg text-white"
        end

      "default" ->
        case variant do
          "solid" ->
            "text-white bg-gray-900"

          "outline" ->
            "text-gray-900 border border-gray-900 dark:border-gray-700 dark:text-gray-400 dark:hover:text-default dark:hover:border-blue-600 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "soft" ->
            "text-gray-900 bg-gray-100 hover:bg-gray-200 dark:hover:bg-blue-900 dark:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "white" ->
            "border border-gray-200 bg-white text-gray-900 shadow-sm hover:bg-gray-100 dark:bg-slate-900 dark:border-gray-700 dark:text-white dark:hover:bg-gray-800 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "ghost" ->
            "text-gray-900 hover:bg-gray-200 dark:text-blue-500 dark:hover:bg-blue-800/30 dark:hover:text-blue-400 dark:focus:outline-none dark:focus:ring-1 dark:focus:ring-gray-600"

          "shadow" ->
            "bg-gray-900 shadow-md shadow-gray-900/50 hover:shadow-lg text-gray-100"
        end

        # "secondary" ->
        #   "text-blue-600 bg-secondary hover:bg-purple-900"

        # "success" ->
        #   "text-white bg-success hover:bg-green-600"

        # "warning" ->
        #   "text-white bg-warning hover:bg-yellow-600"

        # "danger" ->
        #   "text-white bg-danger hover:bg-red-600"

        # "default" ->
        #   "text-gray-100 bg-gray-700 hover:bg-gray-800"
    end
  end

  defp size_classes(size) do
    case size do
      "sm" ->
        "py-2 px-3 gap-x-2 text-sm"

      "md" ->
        "py-3 px-4 gap-x-2 text-base"

      "lg" ->
        "p-4 sm:p-5 gap-x-2 text-md"
    end
  end

  defp radius_classes(radius) do
    case radius do
      "xs" -> "rounded-xs"
      "sm" -> "rounded-sm"
      "md" -> "rounded-md"
      "lg" -> "rounded-lg"
      "xl" -> "rounded-xl"
      "full" -> "rounded-full"
      "none" -> "rounded-none"
    end
  end

  # defp variant_classes(assigns) do
  #   case assigns.variant do
  #     "solid" ->
  #       ""

  #     "bordered" ->
  #       ""

  #     "light" ->
  #       "border-2 border-primary hover:bg-blue-100 text-primary"

  #     "flat" ->
  #       "text-primary bg-blue-100 hover:text-blue-200"

  #     "ghost" ->
  #       "border-2 border-primary hover:bg-primary text-primary hover:text-blue-50"

  #     "shadow" ->
  #       "bg-danger shadow-lg hover:bg-blue-400 shadow-blue-400"
  #   end
  # end
end
