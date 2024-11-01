defmodule AvatarGroup do
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router
  import Avatar

  attr(:class, :string, default: "")
  attr(:size, :string, default: "md", values: ["sm", "md", "lg"])
  attr(:limit, :integer, default: 3)
  attr(:name, :string, default: "")
  attr(:variant, :string, default: "stack", values: ["stack", "grid"])

  attr(:src, :string, default: nil)
  attr(:placeholder, :string, default: nil)
  attr(:avatars, :list,
    required: true,
    doc: "The list of Avatars to be rendered. Each avatar to be passed as a map"
  )

  def avatar_group(%{variant: "stack"} = assigns) do
    ~H"""
    <div class={["flex -space-x-2", @class]}>
      <%= for {avatar, index} <- Enum.with_index(@avatars), index < @limit do %>
        <.avatar
          id={"avatar-#{index}"}
          phx-hook="Tooltip"
          data-tippy-content={Map.get(avatar, :placeholder, "")}
          placeholder={Map.get(avatar, :placeholder, "")}
          class={"inline-block z-0 relative hover:z-30 #{@class}"}
          src={avatar.src}
          size={@size}
          status={Map.get(avatar, :status, false)}
        />
      <% end %>

      <button
        :if={length(@avatars) - @limit != 0}
        class={"z-50 #{Avatar.size(@size)} -ml-4 inline-flex rounded-full items-center justify-center rounded-full bg-gray-100 border-2 border-white font-medium text-gray-700 shadow-sm align-middle hover:bg-gray-200 focus:outline-none focus:bg-gray-300 text-sm dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600 dark:focus:bg-neutral-600 dark:border-neutral-800"}
        aria-haspopup="menu"
        aria-expanded="false"
        aria-label="Dropdown"
      >
        <span class="font-medium leading-none">
          <%= to_string(length(@avatars) - @limit) <> "+" %>
        </span>
      </button>
    </div>
    """
  end

  def avatar_group(%{variant: "grid"} = assigns) do
    ~H"""
    <div class="grid grid-cols-3 gap-4">
      <%= for {avatar, index} <- Enum.with_index(@avatars), index < @limit do %>
        <.avatar
          id={"avatar-#{index}"}
          phx-hook="Tooltip"
          data-tippy-content={Map.get(avatar, :placeholder, "")}
          placeholder={Map.get(avatar, :placeholder, "")}
          class={"inline-block relative #{@class}"}
          src={avatar.src}
          size={@size}
          status={Map.get(avatar, :status, false)}
        />
      <% end %>

      <span
        :if={length(@avatars) - @limit != 0}
        class={"inline-flex items-center justify-center #{Avatar.size(@size)} rounded-full bg-gray-100 border-2 border-gray-200 dark:bg-neutral-600 dark:border-neutral-700"}
      >
        <span class="font-medium text-gray-500 leading-none dark:text-neutral-400">
          <%= to_string(length(@avatars) - @limit) <> "+" %>
        </span>
      </span>
    </div>
    """
  end
end
