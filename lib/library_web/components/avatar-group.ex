defmodule AvatarGroup do
  use Phoenix.Component
  import Avatar

  attr :class, :string, default: ""
  attr :size, :string, default: "md", values: ["sm", "md", "lg"]
  attr :limit, :integer, default: 3
  attr :name, :string, default: ""
  attr :variant, :string, default: "stack", values: ["stack", "grid"]

  attr :color, :string,
    default: "gray-200",
    values: ["primary", "secondary", "success", "warning", "danger", "gray-200"]

  attr :isBordered, :boolean, default: false

  attr :src, :string, default: nil
  attr :placeholder, :string, default: nil

  def avatar_group(%{variant: "stack"} = assigns) do
    ~H"""
    <div class={["flex -space-x-4", @class]}>
      <%= for {avatar, index} <- Enum.with_index(@avatars), index < @limit do %>
        <.avatar
          placeholder={Map.get(avatar, :name, "")}
          class={get_avatar_group_classes(assigns)}
          color={@color}
          isBordered={@isBordered}
          src={avatar.src}
          size={@size}
        />
      <% end %>
      <div
        :if={length(@avatars) - @limit != 0}
        class={"inline-flex items-center justify-center rounded-full z-50 #{avatar_size_class(assigns[:size])} #{color_class(assigns[:color])}"}
      >
        <%= to_string(length(@avatars) - @limit) <> "+" %>
      </div>
    </div>
    """
  end

  def avatar_group(%{variant: "grid"} = assigns) do
    ~H"""
    <div class="grid grid-cols-3 gap-4">
      <%= for {avatar, index} <- Enum.with_index(@avatars), index < @limit do %>
        <.avatar
          placeholder={Map.get(avatar, :name, "")}
          class={get_avatar_group_classes(assigns)}
          color={@color}
          isBordered={@isBordered}
          src={avatar.src}
          size={@size}
        />
      <% end %>
      <div
        :if={length(@avatars) - @limit != 0}
        class={"inline-flex items-center justify-center rounded-full z-50 #{avatar_size_class(assigns[:size])} #{color_class(assigns[:color])}"}
      >
        <%= to_string(length(@avatars) - @limit) <> "+" %>
      </div>
    </div>
    """
  end

  def get_avatar_group_classes(assigns) do
    "inline-block ring-1 ring-white dark:ring-gray-800 z-0 #{assigns[:class]}"
  end
end
