defmodule Avatar do
  @moduledoc """
  This is documentation for the entire module
  """
  use Phoenix.Component

  @doc """
  This is documentation for the avatar function

  <.avatar src="https://avatars.githubusercontent.com/u/10400064?v=4" />

  """

  attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]

  attr :variant, :string,
    default: "solid",
    values: ["solid", "outline", "inverted", "shadow"]

  attr :color, :string,
    default: "gray-200",
    values: ["primary", "secondary", "success", "warning", "danger", "gray-200"]

  attr :class, :string, default: ""
  attr :isBordered, :boolean, default: false

  attr :src, :string, default: nil
  attr :placeholder, :string, default: nil
  attr :cond, :boolean, default: false

  def avatar(assigns) do
    ~H"""
    <div class="relative inline-block">
      <%= if src_blank?(@src) && !@placeholder do %>
        <div class={"flex border p-1.5 bg-gray-100 #{color_class(assigns[:color])} items-center justify-center rounded-full #{avatar_size_class(assigns[:size])}"}>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"
            />
          </svg>
        </div>
      <% else %>
        <%= if src_blank?(@src) && @placeholder do %>
          <div class={"flex font-medium items-center justify-center text-lg #{color_class(assigns[:color])} rounded-full #{avatar_size_class(assigns[:size])}"}>
            <%= generate_initials(@placeholder) %>
          </div>
        <% else %>
          <img src={@src} class={get_avatar_classes(assigns)} />
        <% end %>
      <% end %>
      <span :if={@cond} class="flex absolute top-1 end-1 h-3 w-3 -mt-1.5 -me-1.5">
        <span class="absolute inline-flex w-full h-full rounded-full opacity-75 bg-amber-400 animate-ping dark:bg-red-600">
        </span>
        <span class="relative inline-flex w-3 h-3 rounded-full bg-amber-500"></span>
      </span>
    </div>
    """
  end

  defp get_avatar_classes(assigns) do
    # Include in the documentation that rounded-sm will superseed the rounded-full class
    "rounded-full #{avatar_size_class(assigns[:size])} #{border_class(assigns[:isBordered])} #{color_class(assigns[:color])} #{assigns.class}"
  end

  def avatar_size_class(size) do
    case size do
      "xs" -> "h-8 w-8"
      "sm" -> "h-10 w-10"
      "md" -> "h-11 w-11"
      "lg" -> "h-12 w-12"
      "xl" -> "h-14 w-14"
      # default size
      _ -> "h-12 w-12"
    end
  end

  def color_class(color) do
    case color do
      "primary" -> "bg-primary border-primary"
      "secondary" -> "bg-secondary border-secondary"
      "success" -> "bg-success border-success"
      "warning" -> "bg-warning border-warning"
      "danger" -> "bg-danger border-danger"
      "gray-200" -> "bg-gray-200 border-gray-200"
    end
  end

  def border_class(isBordered) do
    case isBordered do
      true -> "border-3"
      _ -> ""
    end
  end

  defp generate_initials(name) do
    word_array = String.split(name)

    if length(word_array) == 1 do
      List.first(word_array)
      |> String.slice(0..1)
      |> String.upcase()
    else
      initial1 = String.first(List.first(word_array))
      initial2 = String.first(List.last(word_array))
      String.upcase(initial1 <> initial2)
    end
  end

  defp src_blank?(src), do: !src || src == ""
end
