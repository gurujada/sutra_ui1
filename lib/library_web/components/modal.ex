# defmodule Modal do
#   use Phoenix.Component
#   alias Phoenix.LiveView.JS

#     attr :class, :string, default: ""
#     attr :id, :string, default: ""
#     attr :show, :boolean, default: true
#     slot :inner_block, required: false
#     attr :close_on_click_away, :boolean,    default: true

#     attr :close_on_escape, :boolean,    default: true

#     # attr :close_modal_target, :string,    default: nil
#     # attr :hide_close_button, :boolean,    default: false
#     attr :rest, :global


#     def modal(assigns) do
#       ~H"""

#       """
#     end

#   def size_class(assigns) do
#     case assigns.size do
#       "sm" -> "sm:max-w-lg sm:w-full sm:mx-auto"
#       "md" -> "md:max-w-2xl md:w-full md:mx-auto"
#       "lg" -> "lg:max-w-4xl lg:w-full lg:mx-auto"
#     end
#   end
# end
