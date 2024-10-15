defmodule Input do
  use Phoenix.Component

  attr :class, :string, default: ""
  attr :placeholder, :string, default: nil
  #   #   # attr :type, :string, default: "text"

  attr :variant, :string,
    default: "basic",
    values: [
      "basic",
      "gray",
      "underline",
      "floating-basic",
      "floating-gray",
      "floating-underline"
    ]

  #   #   attr :label, :string, default: ""
  #   #   attr :value, :string, default: ""
  slot :icon, required: false

  #   #   def input(assigns) do
  #   #     case assigns.variant do
  #   #       "basic" ->
  #   #         ~H"""
  #   #         <label class="block mb-2 text-sm font-medium dark:text-white" for="input"><%= @label %></label>
  #   #         <input
  #   #           value={@value}
  #   #           id="input"
  #   #           placeholder={@placeholder}
  #   #           class="block w-full px-4 py-3 text-sm border-gray-200 rounded-lg focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600"
  #   #           type="email"
  #   #         />
  #   #         """

  #   #       "gray" ->
  #   #         ~H"""
  #   #         <div class="relative">
  #   #           <label class="block mb-2 text-sm font-medium dark:text-white" for="input"><%= @label %></label>

  #   #           <input
  #   #             value={@value}
  #   #             type={@type}
  #   #             class={"block px-4 py-3 text-sm bg-gray-100 border-transparent rounded-lg peer ps-11 focus:border-blue-500 focus:ring-blue-500 dark:bg-gray-700 dark:border-transparent dark:text-gray-400 dark:focus:ring-gray-600 #{assigns.class}"}
  #   #             placeholder={@placeholder}
  #   #           />
  #   #           <div class="absolute inset-y-0 flex items-center pointer-events-none start-0 ps-4 peer-disabled:opacity-50 peer-disabled:pointer-events-none">
  #   #             <%= if @icon do %>
  #   #               <%= render_slot(@icon) %>
  #   #             <% end %>
  #   #           </div>
  #   #         </div>
  #   #         """

  #   #       "underline" ->
  #   #         ~H"""
  #   #         <div class="relative">
  #   #           <input
  #   #             value={@value}
  #   #             type={@type}
  #   #             class={"block py-3 text-sm bg-transparent border-b-2 peer pe-0 ps-8 border-t-transparent border-x-transparent border-b-gray-200 focus:border-t-transparent focus:border-x-transparent focus:border-b-blue-500 focus:ring-0 dark:border-b-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 dark:focus:border-b-gray-600 #{assigns.class}"}
  #   #             placeholder={@placeholder}
  #   #           />
  #   #           <div class="absolute inset-y-0 flex items-center pointer-events-none start-0 ps-2 peer-disabled:opacity-50 peer-disabled:pointer-events-none">
  #   #             <%= if @icon do %>
  #   #               <%= render_slot(@icon) %>
  #   #             <% end %>
  #   #           </div>
  #   #         </div>
  #   #         """

  #   #       "floating-basic" ->
  #   #         ~H"""
  #   #         <div class="relative">
  #   #           <input
  #   #             value={@value}
  #   #             type={@type}
  #   #             id="hs-floating-input-email"
  #   #             class={"peer p-4 block w-full border-gray-200 rounded-lg text-sm placeholder:text-transparent focus:placeholder:text-gray-700 focus:border-blue-500 focus:ring-blue-500 dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class}"}
  #   #             placeholder={@placeholder}
  #   #           />
  #   #           <label
  #   #             for="hs-floating-input-email"
  #   #             class="absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none
  #   #         peer-focus:text-xs
  #   #         peer-focus:-translate-y-1.5
  #   #         peer-focus:text-gray-500
  #   #         peer-[:not(:placeholder-shown)]:text-xs
  #   #         peer-[:not(:placeholder-shown)]:-translate-y-1.5
  #   #         peer-[:not(:placeholder-shown)]:text-gray-500"
  #   #           >
  #   #             Email
  #   #           </label>
  #   #         </div>
  #   #         """

  #   #       "floating-gray" ->
  #   #         ~H"""
  #   #         <div class="relative">
  #   #           <input
  #   #             value={@value}
  #   #             type={@type}
  #   #             id="hs-floating-gray-input-email"
  #   #             class={"peer p-4 block w-full bg-gray-100 border-transparent rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-gray-700 dark:border-transparent dark:text-gray-400 dark:focus:ring-gray-600
  #   #         focus:pt-6
  #   #         focus:pb-2
  #   #         [&:not(:placeholder-shown)]:pt-6
  #   #         [&:not(:placeholder-shown)]:pb-2
  #   #         autofill:pt-6
  #   #         autofill:pb-2 #{assigns.class}"}
  #   #             placeholder={@placeholder}
  #   #           />
  #   #           <label
  #   #             for="hs-floating-gray-input-email"
  #   #             class="absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none
  #   #         peer-focus:text-xs
  #   #         peer-focus:-translate-y-1.5
  #   #         peer-focus:text-gray-500
  #   #         peer-[:not(:placeholder-shown)]:text-xs
  #   #         peer-[:not(:placeholder-shown)]:-translate-y-1.5
  #   #         peer-[:not(:placeholder-shown)]:text-gray-500"
  #   #           >
  #   #             Email
  #   #           </label>
  #   #         </div>
  #   #         """

  #   #       "floating-underline" ->
  #   #         ~H"""
  #   #         <div class="relative">
  #   #           <input
  #   #             value={@value}
  #   #             type={@type}
  #   #             id="hs-floating-underline-input-email"
  #   #             class={"peer py-4 px-0 block w-full bg-transparent border-t-transparent border-b-2 border-x-transparent border-b-gray-200 text-sm placeholder:text-transparent focus:border-t-transparent focus:border-x-transparent focus:border-b-blue-500 focus:ring-0 disabled:opacity-50 disabled:pointer-events-none dark:border-b-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 dark:focus:border-b-gray-600
  #   #         focus:pt-6
  #   #         focus:pb-2
  #   #         [&:not(:placeholder-shown)]:pt-6
  #   #         [&:not(:placeholder-shown)]:pb-2
  #   #         autofill:pt-6
  #   #         autofill:pb-2 #{assigns.class}"}
  #   #             placeholder={@placeholder}
  #   #           />
  #   #           <label
  #   #             for="hs-floating-underline-input-email"
  #   #             class="absolute top-0 start-0 py-4 px-0 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none
  #   #         peer-focus:text-xs
  #   #         peer-focus:-translate-y-1.5
  #   #         peer-focus:text-gray-500
  #   #         peer-[:not(:placeholder-shown)]:text-xs
  #   #         peer-[:not(:placeholder-shown)]:-translate-y-1.5
  #   #         peer-[:not(:placeholder-shown)]:text-gray-500"
  #   #           >
  #   #             Email
  #   #           </label>
  #   #         </div>
  #   #         """
  #   #     end
  #   #   end

  #   This
  #   is
  #   v1
  #   !
  #   !
  #   attr :id, :any, default: nil
  #   attr :name, :string, default: ""
  #   attr :label, :string, default: nil
  #   attr :value, :string, default: ""

  #   attr :type, :string,
  #     default: "text",
  #     values: ~w(checkbox color date datetime-local email file hidden month number password
  #                range radio search select tel text textarea time url week)

  #   attr :field, Phoenix.HTML.FormField,
  #     doc: "a form field struct retrieved from the form, for example: @form[:email]"

  #   attr :errors, :list, default: []
  #   # attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  #   # attr :prompt, :string, default: nil, doc: "the prompt for select inputs"
  #   # attr :options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2"
  #   # attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"

  #   attr :rest, :global,
  #     include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
  #                 multiple pattern placeholder readonly required rows size step)

  #   def input(assigns) do
  #     ~H"""
  #     <div phx-feedback-for={@name}>
  #       <.label for={@id}><%= @label %></.label>
  #       <input
  #         type={@type}
  #         name={@name}
  #         id={@id}
  #         value={Phoenix.HTML.Form.normalize_value(@type, @value)}
  #         class={[
  #           "mt-2 block w-full rounded-lg text-zinc-900 focus:ring-0 sm:text-sm sm:leading-6",
  #           "phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400",
  #           @errors == [] && "border-zinc-300 focus:border-zinc-400",
  #           @errors != [] && "border-rose-400 focus:border-rose-400"
  #         ]}
  #       />
  #       <.error :for={msg <- @errors}><%= msg %></.error>
  #     </div>
  #     """
  #   end

  #   def label(assigns) do
  #     ~H"""
  #     <label for={@for} class="block text-sm font-semibold leading-6 text-zinc-800">
  #       <%= render_slot(@inner_block) %>
  #     </label>
  #     """
  #   end

  #   def error(assigns) do
  #     ~H"""
  #     <p class="flex gap-3 mt-3 text-sm leading-6 text-rose-600 phx-no-feedback:hidden">
  #       <%!-- <.icon name="hero-exclamation-circle-mini" class="mt-0.5 h-5 w-5 flex-none" /> --%>
  #       <%= render_slot(@inner_block) %>
  #     </p>
  #     """
  #   end
  # end

  attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any

  attr :type, :string,
    default: "text",
    values: ~w(checkbox color date datetime-local email file hidden month number password
               range radio search select tel text textarea time url week)

  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :errors, :list, default: []
  attr :checked, :boolean, doc: "the checked flag for checkbox inputs"
  attr :prompt, :string, default: nil, doc: "the prompt for select inputs"
  attr :options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2"
  attr :multiple, :boolean, default: false, doc: "the multiple flag for select inputs"

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  slot :inner_block
  # HAVE TO INCLUDE @REST, @FORM AND @DISABLED

  @error_classes "border-red-500 focus:border-red-500 focus:ring-red-500"
  @no_error_classes "border-teal-500 focus:border-green-500 focus:ring-green-500"
  attr :error_classes, :string, default: @error_classes
  attr :no_error_classes, :string, default: @no_error_classes
  # def input(assigns) do
  #   ~H"""
  #   <div phx-feedback-for={@name}>
  #     <.label for={@id}><%= @label %></.label>
  #     <input
  #       type={@type}
  #       name={@name}
  #       id={@id}
  #       value={Phoenix.HTML.Form.normalize_value(@type, @value)}
  #       class={[
  #         "mt-2 block w-full rounded-lg text-zinc-900 focus:ring-0 sm:text-sm sm:leading-6",
  #         "phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400",
  #         @errors == [] && "border-zinc-300 focus:border-zinc-400",
  #         @errors != [] && "border-rose-400 focus:border-rose-400"
  #       ]}
  #     />
  #     <.error :for={msg <- @errors}><%= msg %></.error>
  #   </div>
  #   """
  # end

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(field.errors, &translate_error(&1)))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(%{type: "textarea"} = assigns) do
    case assigns.variant do
      "basic" ->
        ~H"""
        <div class="relative" phx-feedback-for={@name}>
          <label for={@id} class="block mb-2 text-sm font-medium dark:text-white"><%= @label %></label>
          <textarea
            id={@id || @name}
            name={@name}
            class={[
              "min-h-[6rem] py-3 px-4 block w-full rounded-lg text-sm disabled:opacity-50 disabled:pointer-events-none phx-no-feedback:border-gray-300 #{assigns.class}",
              @errors == [] && @no_error_classes,
              @errors != [] && @error_classes
            ]}
            {@rest}
          ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
          <LibraryWeb.CoreComponents.error :for={msg <- @errors}>
            <%= msg %>
          </LibraryWeb.CoreComponents.error>

          <div
            :if={@errors == []}
            class="absolute flex items-center p-3 pointer-events-none bottom-8 right-4 end-2 phx-no-feedback:hidden"
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
            :if={@errors != []}
            class="absolute top-0 flex items-center p-3 pointer-events-none end-0 phx-no-feedback:hidden"
          >
            <svg
              class="flex-shrink-0 w-4 h-4 text-teal-500"
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
        """

      _ ->
        ""
        # "gray" ->
        #   ~H"""
        #   <div phx-feedback-for={@name} class="relative">
        #     <label class="block mb-2 text-sm font-medium dark:text-white" for={@id}><%= @label %></label>

        #     <textarea
        #       id={@id}
        #       name={@name}
        #       class={[
        #         "py-3 px-4 block w-full bg-gray-100 border-transparent rounded-lg text-sm focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-gray-700 dark:border-transparent dark:text-gray-400 dark:focus:ring-gray-600 #{assigns.class}",
        #         @errors == [] && @no_error_classes,
        #         @errors != [] && @error_classes
        #       ]}
        #       placeholder={@placeholder}
        #     > <%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
        #   </div>
        #   """

        # "underline" ->
        #   ~H"""
        #   <div phx-feedback-for={@name} class="relative">
        #     <textarea
        #       id={@id}
        #       {@rest}
        #       name={@name}
        #       placeholder={@placeholder}
        #       class={[
        #         "w-full block py-3 text-sm bg-transparent border-b-2 peer  border-t-transparent border-x-transparent border-b-gray-200 focus:border-t-transparent focus:border-x-transparent focus:border-b-blue-500 focus:ring-0 dark:border-b-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 dark:focus:border-b-gray-600 #{assigns.class}",
        #         @errors == [] && @no_error_classes,
        #         @errors != [] && @error_classes
        #       ]}
        #     ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
        #   </div>
        #   """

        # "floating-basic" ->
        #   ~H"""
        #   <div phx-feedback-for={@name} class="relative">
        #     <textarea
        #       id={@id}
        #       {@rest}
        #       name={@name}
        #       class={"peer p-4 block w-full border-gray-200 rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class} #{error_classes(assigns)}"}
        #       placeholder={@placeholder}
        #     > <%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
        #     <label
        #       for={@id}
        #       class={"absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none peer-focus:text-xs peer-focus:-translate-y-1.5 peer-focus:text-gray-500 peer-[:not(:placeholder-shown)]:text-xs peer-[:not(:placeholder-shown)]:-translate-y-1.5 peer-[:not(:placeholder-shown)]:text-gray-500 #{error_classes(assigns)}"}
        #     >
        #       <%= @label %>
        #     </label>
        #   </div>
        #   """

        # "floating-gray" ->
        #   ~H"""
        #   <div phx-feedback-for={@name} class="relative">
        #     <textarea
        #       id={@id}
        #       {@rest}
        #       name={@name}
        #       class={"peer p-4 block w-full bg-gray-100 border-transparent rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-gray-700 dark:border-transparent dark:text-gray-400 dark:focus:ring-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class} #{error_classes(assigns)}"}
        #       placeholder={@placeholder}
        #     > <%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
        #     <label
        #       for={@id}
        #       class="absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none peer-focus:text-xs peer-focus:-translate-y-1.5 peer-focus:text-gray-500 peer-[:not(:placeholder-shown)]:text-xs peer-[:not(:placeholder-shown)]:-translate-y-1.5 peer-[:not(:placeholder-shown)]:text-gray-500"
        #     >
        #       <%= @label %>
        #     </label>
        #   </div>
        #   """

        # "floating-underline" ->
        #   ~H"""
        #   <div class="relative">
        #     <textarea
        #       id={@id}
        #       {@rest}
        #       name={@name}
        #       class={"peer py-4 px-0 block w-full bg-transparent border-t-transparent border-b-2 border-x-transparent border-b-gray-200 text-sm placeholder:text-transparent focus:border-t-transparent focus:border-x-transparent focus:border-b-blue-500 focus:ring-0 disabled:opacity-50 disabled:pointer-events-none dark:border-b-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 dark:focus:border-b-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class} #{error_classes(assigns)}"}
        #       placeholder={@placeholder}
        #     ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
        #     <label
        #       for={@id}
        #       class="absolute top-0 start-0 py-4 px-0 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none peer-focus:text-xs peer-focus:-translate-y-1.5 peer-focus:text-gray-500 peer-[:not(:placeholder-shown)]:text-xs peer-[:not(:placeholder-shown)]:-translate-y-1.5 peer-[:not(:placeholder-shown)]:text-gray-500"
        #     >
        #       <%= @label %>
        #     </label>
        #   </div>
        #   """
    end
  end

  def input(%{type: "checkbox"} = assigns) do
    ~H"""
    <div class="flex" phx-feedback-for={@name}>
      <%!-- <input type="hidden" name={@name} value="false" /> --%>
      <label class="text-sm text-gray-500 ms-3 dark:text-gray-400">
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value="true"
          checked={@checked}
          class="shrink-0 mt-0.5 border-gray-200 rounded text-blue-600 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-gray-800 dark:border-gray-700 dark:checked:bg-blue-500 dark:checked:border-blue-500 dark:focus:ring-offset-gray-800"
          {@rest}
        />
        <%= @label %>
      </label>
      <.error :for={msg <- @errors}><%= msg %></.error>
    </div>
    """
  end

  def input(assigns) do
    case assigns.variant do
      "basic" ->
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
          <.error :for={msg <- @errors}>
            <%= msg %>
          </.error>
        </div>
        """

      "gray" ->
        ~H"""
        <div phx-feedback-for={@name}>
          <label class="block mb-2 text-sm font-medium dark:text-white" for={@id}><%= @label %></label>
          <div class="relative">
            <input
              value={Phoenix.HTML.Form.normalize_value(@type, @value)}
              id={@id}
              name={@name}
              type={@type}
              class={[
                "w-full block px-4 py-3 text-sm border-transparent rounded-lg focus:ring-0 phx-no-feedback:focus:border-blue-500 phx-no-feedback:focus:ring-blue-500 phx-no-feedback:bg-gray-100 dark:bg-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 #{assigns.class}",
                @icon && "ps-11",
                @errors == [] &&
                  "bg-green-100/75",
                @errors != [] &&
                  "bg-red-100/50"
              ]}
              {@rest}
            />
            <div
              :if={@icon}
              class="absolute inset-y-0 flex items-center pointer-events-none start-0 ps-4 peer-disabled:opacity-50 peer-disabled:pointer-events-none"
            >
              <%= if @icon do %>
                <%= render_slot(@icon) %>
              <% end %>
            </div>
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
          <.error :for={msg <- @errors}>
            <%= msg %>
          </.error>
        </div>
        """

      "underline" ->
        ~H"""
        <div phx-feedback-for={@name} class="relative">
          <input
            value={Phoenix.HTML.Form.normalize_value(@type, @value)}
            id={@id}
            {@rest}
            name={@name}
            type={@type}
            class={[
              "w-full block py-3 text-sm bg-transparent border-b-2 peer pe-0 ps-8 border-t-transparent border-x-transparent phx-no-feedback:border-b-gray-200 focus:border-t-transparent focus:border-x-transparent phx-no-feedback:focus:border-b-blue-500 focus:ring-0 dark:border-b-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 dark:focus:border-b-gray-600 #{assigns.class}",
              @errors == [] &&
                "bg-green-100/75 border-b-green-300",
              @errors != [] &&
                "bg-red-100/50 border-b-red-400"
            ]}
          />
          <div class="absolute inset-y-0 flex items-center pointer-events-none start-0 ps-2 peer-disabled:opacity-50 peer-disabled:pointer-events-none">
            <%= if @icon do %>
              <%= render_slot(@icon) %>
            <% end %>
          </div>
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
          <.error :for={msg <- @errors}>
            <%= msg %>
          </.error>
        </div>
        """

      "floating-basic" ->
        ~H"""
        <div phx-feedback-for={@name}>
          <div class="relative">
            <input
              value={Phoenix.HTML.Form.normalize_value(@type, @value)}
              id={@id}
              {@rest}
              name={@name}
              type={@type}
              placeholder={@placeholder}
              class={[
                "peer p-4 block w-full border-1 focus:ring-0 phx-no-feedback:border-gray-200 phx-no-feedback:bg-white rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 dark:bg-slate-900 dark:border-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class}",
                @errors == [] &&
                  "border-green-500",
                @errors != [] &&
                  "border-red-500"
              ]}
            />
            <label
              for={@id}
              class="absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none peer-focus:text-xs peer-focus:-translate-y-1.5 peer-focus:text-gray-500 peer-[:not(:placeholder-shown)]:text-xs peer-[:not(:placeholder-shown)]:-translate-y-1.5 peer-[:not(:placeholder-shown)]:text-gray-500"
            >
              <%= @label %>
            </label>
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
          <.error :for={msg <- @errors}>
            <%= msg %>
          </.error>
        </div>
        """

      "floating-gray" ->
        ~H"""
        <div phx-feedback-for={@name}>
          <div class="relative">
            <input
              value={Phoenix.HTML.Form.normalize_value(@type, @value)}
              id={@id}
              {@rest}
              name={@name}
              type={@type}
              placeholder={@placeholder}
              class={[
                "peer p-4 block w-full bg-gray-100 border-transparent rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-gray-700 dark:border-transparent dark:text-gray-400 dark:focus:ring-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class}",
                @errors == [] &&
                  "bg-green-100/75",
                @errors != [] &&
                  "bg-red-100/50"
              ]}
            />
            <label
              for={@id}
              class="absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none peer-focus:text-xs peer-focus:-translate-y-1.5 peer-focus:text-gray-500 peer-[:not(:placeholder-shown)]:text-xs peer-[:not(:placeholder-shown)]:-translate-y-1.5 peer-[:not(:placeholder-shown)]:text-gray-500"
            >
              <%= @label %>
            </label>
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
          <.error :for={msg <- @errors}>
            <%= msg %>
          </.error>
        </div>
        """

      "floating-underline" ->
        ~H"""
        <div phx-no-feedback={@name}>
          <div class="relative">
            <input
              value={Phoenix.HTML.Form.normalize_value(@type, @value)}
              id={@id}
              {@rest}
              name={@name}
              type={@type}
              placeholder={@placeholder}
              class={[
                "peer py-4 px-0 block w-full bg-transparent border-t-transparent border-b-2 border-x-transparent border-b-gray-200 text-sm placeholder:text-transparent focus:border-t-transparent focus:border-x-transparent focus:border-b-blue-500 focus:ring-0 disabled:opacity-50 disabled:pointer-events-none dark:border-b-gray-700 dark:text-gray-400 dark:focus:ring-gray-600 dark:focus:border-b-gray-600 focus:pt-6 focus:pb-2 [&:not(:placeholder-shown)]:pt-6 [&:not(:placeholder-shown)]:pb-2 autofill:pt-6 autofill:pb-2 #{assigns.class}",
                @errors == [] &&
                  "border-b-green-500",
                @errors != [] &&
                  "border-b-red-500"
              ]}
            />
            <label
              for={@id}
              class="absolute top-0 start-0 py-4 px-0 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none peer-focus:text-xs peer-focus:-translate-y-1.5 peer-focus:text-gray-500 peer-[:not(:placeholder-shown)]:text-xs peer-[:not(:placeholder-shown)]:-translate-y-1.5 peer-[:not(:placeholder-shown)]:text-gray-500"
            >
              <%= @label %>
            </label>
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
          <.error :for={msg <- @errors}>
            <%= msg %>
          </.error>
        </div>
        """
    end
  end

  def label(assigns) do
    ~H"""
    <label for={@for} class="block text-sm font-semibold leading-6 text-zinc-800">
      <%= render_slot(@inner_block) %>
    </label>
    """
  end

  def error(assigns) do
    ~H"""
    <p class="flex gap-3 mt-3 leading-6 text- text-rose-600 phx-no-feedback:hidden">
      <%!-- <.icon name="hero-exclamation-circle-mini" class="mt-0.5 h-5 w-5 flex-none" /> --%>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(LibraryWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(LibraryWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end
end
