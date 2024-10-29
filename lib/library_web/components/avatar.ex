defmodule Avatar do
  @moduledoc """
  This is documentation for the entire module
  """
  use Phoenix.Component
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  @doc """
  This is documentation for the avatar function

  <.avatar src="https://avatars.githubusercontent.com/u/10400064?v=4" />
  """
  attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg"]
  attr :class, :string, default: ""
  attr :border, :boolean, default: false

  attr :src, :string, default: ""

  attr :placeholder, :string,
    default: nil,
    doc: "The Name of the User to be shown if the src is empty"

  attr :status, :boolean, default: false, doc: "The condition to show the avatar with a badge"
  attr :rest, :global, doc: "he arbitrary HTML attributes that can be passed to the avatar"

  attr :to, :string,
    default: "#",
    doc: "The path to patch the liveview to - most likely the user profile"

  def avatar(assigns) do
    ~H"""
    <div class="relative inline-block">
      <.link patch={~p"/#{@to}"}>
        <span
          :if={@src == "" && !@placeholder}
          {@rest}
          class={"inline-block size-6 bg-gray-100 rounded-full overflow-hidden #{avatar_classes(@size, @class)}"}
        >
          <svg
            class="size-full text-gray-300"
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <rect x="0.62854" y="0.359985" width="15" height="15" rx="7.5" fill="white"></rect>
            <path
              d="M8.12421 7.20374C9.21151 7.20374 10.093 6.32229 10.093 5.23499C10.093 4.14767 9.21151 3.26624 8.12421 3.26624C7.0369 3.26624 6.15546 4.14767 6.15546 5.23499C6.15546 6.32229 7.0369 7.20374 8.12421 7.20374Z"
              fill="currentColor"
            >
            </path>
            <path
              d="M11.818 10.5975C10.2992 12.6412 7.42106 13.0631 5.37731 11.5537C5.01171 11.2818 4.69296 10.9631 4.42107 10.5975C4.28982 10.4006 4.27107 10.1475 4.37419 9.94123L4.51482 9.65059C4.84296 8.95684 5.53671 8.51624 6.30546 8.51624H9.95231C10.7023 8.51624 11.3867 8.94749 11.7242 9.62249L11.8742 9.93184C11.968 10.1475 11.9586 10.4006 11.818 10.5975Z"
              fill="currentColor"
            >
            </path>
          </svg>
        </span>

        <span
          :if={@src == "" && @placeholder}
          class="inline-flex items-center justify-center size-8 rounded-full bg-gray-500 text-xs font-semibold text-white leading-none"
          {@rest}
        >
          <%= generate_initials(@placeholder) %>
        </span>
        <img :if={@src != ""} src={@src} class={avatar_classes(@size, @class)} {@rest} />

        <span
          :if={@status}
          class={[
            "absolute top-0 end-0 block #{status_size(@size)} rounded-full z-50 ring-2 ring-white bg-blue-400 dark:ring-neutral-900",
            String.contains?(@class, "rounded") && "transform -translate-y-1/2 translate-x-1/2"
          ]}
        >
        </span>
      </.link>
    </div>
    """
  end

  defp avatar_classes(size, class) do
    # Include in the documentation that rounded-sm will superseed the rounded-full class
    "rounded-full inline-block ring-2 ring-white dark:ring-neutral-900 #{size(size)} #{class}"
  end

  def size(size) do
    case size do
      "xs" -> "size-8"
      "sm" -> "size-[38px]"
      "md" -> "size-[46px]"
      "lg" -> "size-[62px]"
    end
  end

  def status_size(size) do
    case size do
      "xs" -> "size-1.5"
      "sm" -> "size-2.5"
      "md" -> "size-3"
      "lg" -> "size-3.5"
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
end
