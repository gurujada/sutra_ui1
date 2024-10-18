defmodule Library.Input do
  use Phoenix.Component

  attr :label, :string, default: ""
  attr :variant, :string, values: ["gray", "default", "underlined"], default: "default"
  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step type)

  def input(assigns = %{variant: "default"}) do
    ~H"""
    <div phx-feedback-for={@name}>
      <label for={@id} class="block mb-2 text-sm font-medium dark:text-white"><%= @label %></label>
      <div class="relative">
        <input
          type={@type}
          name={@name}
          id={@id}
          value={Phoenix.HTML.Form.normalize_value(@type, @value)}
          {@rest}
          class={[
            "py-3 px-4 block w-full rounded-lg text-sm dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 phx-no-feedback:border-gray-300 phx-no-feedback:focus:border-blue-500 phx-no-feedback:focus:ring-blue-500 #{assigns.class}",
            @errors == [] &&
              @no_error_classes,
            @errors != [] &&
              @error_classes
          ]}
        />
        <div
          :if={@errors != []}
          class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3 phx-no-feedback:hidden"
        >
          <svg
            class="flex-shrink-0 w-5 h-5 text-red-500"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <circle cx="12" cy="12" r="10" /><line x1="12" x2="12" y1="8" y2="12" /><line
              x1="12"
              x2="12.01"
              y1="16"
              y2="16"
            />
          </svg>
        </div>

        <div
          :if={@errors == []}
          class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3 phx-no-feedback:hidden"
        >
          <svg
            class="flex-shrink-0 w-4 h-4 text-green-500"
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <polyline points="20 6 9 17 4 12" />
          </svg>
        </div>
      </div>
      <Error.error :for={msg <- @errors}>
        <%= msg %>
      </Error.error>
    </div>
    """
  end

  def input(assigns = %{variant: "gray"}) do
    ~H"""
    <div class="relative">
        <input type="email"
        {@rest}
        class="peer py-3 px-4 ps-11 block w-full bg-gray-100 border-transparent rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-700 dark:border-transparent dark:text-neutral-400 dark:placeholder-neutral-500 dark:focus:ring-neutral-600" placeholder="Enter name" />
        <div class="absolute inset-y-0 start-0 flex items-center pointer-events-none ps-4 peer-disabled:opacity-50 peer-disabled:pointer-events-none">
          <svg class="shrink-0 h-4 w-4 text-gray-500 dark:text-neutral-500" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
            <circle cx="12" cy="7" r="4"></circle>
          </svg>
        </div>
      </div>
    """
  end
end
