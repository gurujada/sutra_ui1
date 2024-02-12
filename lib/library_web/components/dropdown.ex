# defmodule Dropdown do
#   use Phoenix.Component

#   # attr(:id, :string, required: true)
#   # slot(:content, required: true)
#   # slot(:button, required: true)

#   # def dropdown(assigns) do
#   #   ~H"""
#   #   <div class="relative" data-component="dropdown">
#   #     <button
#   #       type="button"
#   #       class="inline-flex w-full justify-center gap-x-1.5 rounded-md bg-white px-3 py-2 text-sm shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
#   #       id={"#{@id}-button"}
#   #       aria-expanded="false"
#   #       phx-click={Phoenix.LiveView.JS.dispatch("toggle", to: "##{@id}-menu")}
#   #       phx-click-away={Phoenix.LiveView.JS.dispatch("close", to: "##{@id}-menu")}
#   #       phx-window-keydown={Phoenix.LiveView.JS.dispatch("close", to: "##{@id}-menu")}
#   #       phx-key="Escape"
#   #     >
#   #       <%= render_slot(@button) %>
#   #     </button>

#   #     <nav
#   #       hidden="true"
#   #       class="absolute right-0 z-10 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5"
#   #       id={"#{@id}-menu"}
#   #     >
#   #       > <%= render_slot(@content) %>
#   #     </nav>
#   #   </div>
#   #   """
#   # end

#   # def toggle_dropdown(js, id) do
#   #   js
#   #   |> JS.toggle(
#   #     to: "##{@id}-menu",
#   #     in: {"ease-out duration-100", "opacity-0 scale-95", "opacity-100 scale-100"},
#   #     out: {"ease-out duration-75", "opacity-100 scale-100", "opacity-0 scale-95"}
#   #   )
#   #   |> JS.set_attr(
#   #     "aria-expanded",
#   #     # How do we get this value?
#   #     "???",
#   #     to: "##{id}-button"
#   #   )
#   # end

#   # def chevron_down(assigns) do
#   #   ~H"""
#   #   <svg
#   #     class="-mr-1 h-5 w-5 text-gray-400"
#   #     viewBox="0 0 20 20"
#   #     fill="currentColor"
#   #     aria-hidden="true"
#   #   >
#   #     <path
#   #       fill-rule="evenodd"
#   #       d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z"
#   #       clip-rule="evenodd"
#   #     />
#   #   </svg>
#   #   """
#   # end

#   alias Phoenix.LiveView.JS

#   @transition_in_base "transition transform ease-out duration-100"
#   @transition_in_start "transform opacity-0 scale-95"
#   @transition_in_end "transform opacity-100 scale-100"

#   @transition_out_base "transition ease-in duration-75"
#   @transition_out_start "transform opacity-100 scale-100"
#   @transition_out_end "transform opacity-0 scale-95"

#   attr :options_container_id, :string
#   attr :label, :string, default: nil, doc: "labels your dropdown option"
#   attr :class, :string, default: "", doc: "any extra CSS class for the parent container"

#   attr :menu_items_wrapper_class, :string,
#     default: "",
#     doc: "any extra CSS class for menu item wrapper container"

#   attr :js_lib, :string,
#     default: "alpine_js",
#     values: ["alpine_js", "live_view_js"],
#     doc: "javascript library used for toggling"

#   attr :placement, :string, default: "left", values: ["left", "right"]
#   attr :rest, :global

#   slot :trigger_element
#   slot :inner_block, required: false

#   def dropdown(assigns) do
#     assigns =
#       assigns
#       |> assign_new(:options_container_id, fn -> "dropdown_#{Ecto.UUID.generate()}" end)

#     ~H"""
#     <div
#       {@rest}
#       {js_attributes("container", @js_lib, @options_container_id)}
#       class={[@class, "pc-dropdown"]}
#     >
#       <div>
#         <button
#           type="button"
#           class={trigger_button_classes(@label, @trigger_element)}
#           {js_attributes("button", @js_lib, @options_container_id)}
#           aria-haspopup="true"
#         >
#           <span class="sr-only">Open options</span>

#           <%= if @label do %>
#             <%= @label %>
#             <Heroicons.chevron_down solid class="pc-dropdown__chevron" />
#           <% end %>

#           <%= if @trigger_element do %>
#             <%= render_slot(@trigger_element) %>
#           <% end %>

#           <%= if !@label && @trigger_element == [] do %>
#             <Heroicons.ellipsis_vertical solid class="pc-dropdown__ellipsis" />
#           <% end %>
#         </button>
#       </div>
#       <div
#         {js_attributes("options_container", @js_lib, @options_container_id)}
#         class={"#{placement_class(@placement)} #{@menu_items_wrapper_class} pc-dropdown__menu-items-wrapper"}
#         role="menu"
#         id={@options_container_id}
#         aria-orientation="vertical"
#         aria-labelledby="options-menu"
#       >
#         <div class="py-1" role="none">
#           <%= render_slot(@inner_block) %>
#         </div>
#       </div>
#     </div>
#     """
#   end

#   attr :to, :string, default: nil, doc: "link path"
#   attr :label, :string, doc: "link label"
#   attr :class, :string, default: "", doc: "any additional CSS classes"
#   attr :disabled, :boolean, default: false

#   attr :link_type, :string,
#     default: "button",
#     values: ["a", "live_patch", "live_redirect", "button"]

#   attr :rest, :global, include: ~w(method download hreflang ping referrerpolicy rel target type)
#   slot :inner_block, required: false

#   def dropdown_menu_item(assigns) do
#     ~H"""
#     <Link.linkv.a
#       link_type={@link_type}
#       to={@to}
#       class={[@class, "pc-dropdown__menu-item", get_disabled_classes(@disabled)]}
#       disabled={@disabled}
#       {@rest}
#     >
#       <%= render_slot(@inner_block) || @label %>
#     </Link.linkv.a>
#     """
#   end

#   defp trigger_button_classes(nil, []),
#     do: "pc-dropdown__trigger-button--no-label"

#   defp trigger_button_classes(_label, []),
#     do: "pc-dropdown__trigger-button--with-label"

#   defp trigger_button_classes(_label, _trigger_element),
#     do: "pc-dropdown__trigger-button--with-label-and-trigger-element"

#   defp js_attributes("container", "alpine_js", _options_container_id) do
#     %{
#       "x-data": "{open: false}",
#       "@keydown.escape.stop": "open = false",
#       "@click.outside": "open = false"
#     }
#   end

#   defp js_attributes("button", "alpine_js", _options_container_id) do
#     %{
#       "@click": "open = !open",
#       "@click.outside": "open = false",
#       "x-bind:aria-expanded": "open.toString()"
#     }
#   end

#   defp js_attributes("options_container", "alpine_js", _options_container_id) do
#     %{
#       "x-cloak": true,
#       "x-show": "open",
#       "x-transition:enter": @transition_in_base,
#       "x-transition:enter-start": @transition_in_start,
#       "x-transition:enter-end": @transition_in_end,
#       "x-transition:leave": @transition_out_base,
#       "x-transition:leave-start": @transition_out_start,
#       "x-transition:leave-end": @transition_out_end
#     }
#   end

#   defp js_attributes("container", "live_view_js", options_container_id) do
#     %{
#       "phx-click-away":
#         JS.hide(
#           to: "##{options_container_id}",
#           transition: {@transition_out_base, @transition_out_start, @transition_out_end}
#         )
#     }
#   end

#   defp js_attributes("button", "live_view_js", options_container_id) do
#     %{
#       "phx-click":
#         JS.toggle(
#           to: "##{options_container_id}",
#           display: "block",
#           in: {@transition_in_base, @transition_in_start, @transition_in_end},
#           out: {@transition_out_base, @transition_out_start, @transition_out_end}
#         )
#     }
#   end

#   defp js_attributes("options_container", "live_view_js", _options_container_id) do
#     %{
#       style: "display: none;"
#     }
#   end

#   defp placement_class("left"), do: "pc-dropdown__menu-items-wrapper-placement--left"
#   defp placement_class("right"), do: "pc-dropdown__menu-items-wrapper-placement--right"

#   defp get_disabled_classes(true), do: "pc-dropdown__menu-item--disabled"
#   defp get_disabled_classes(false), do: ""
# end
