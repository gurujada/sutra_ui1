defmodule Input do
  use Phoenix.Component
  alias Error
 attr :id, :any, default: nil
  attr :name, :any
  attr :label, :string, default: nil
  attr :value, :any

  attr :class, :string, default: ""
  attr :placeholder, :string, default: nil

  attr :variant, :string,
    default: "default",
    values: [
      "default",
      "gray",
      "underline",
      "floating",
      "floating-gray",
      "floating-underline"
    ]
  attr :icon, :string, default: "hero-"

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

  attr :helper, :string, default: ""
  attr :msg, :string, default: "Looks good!"
  attr :hint, :string, default: ""
  attr :used, :boolean, default: false
  attr :prefix, :string, default: nil
  attr :suffix, :map, default: nil
  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    errors = if Phoenix.Component.used_input?(field), do: field.errors, else: []
    assigns
    |> assign(field: nil, id: assigns.id || field.id)
    |> assign(:errors, Enum.map(errors, &translate_error(&1)))
    |> assign(:used, Phoenix.Component.used_input?(field))
    |> assign_new(:name, fn -> if assigns.multiple, do: field.name <> "[]", else: field.name end)
    |> assign_new(:value, fn -> field.value end)
    |> input()
  end

  def input(%{type: "checkbox", value: value} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn -> Phoenix.HTML.Form.normalize_value("checkbox", value) end)

    ~H"""
    <div phx-feedback-for={@name}>
      <label class="flex items-center gap-4 text-sm leading-6 text-zinc-600">
        <input type="hidden" name={@name} value="false" />
        <input
          type="checkbox"
          id={@id}
          name={@name}
          value="true"
          checked={@checked}
          class="rounded border-zinc-300 text-zinc-900 focus:ring-0"
          {@rest}
        />
        <%= @label %>
      </label>
      <Error.error :for={msg <- @errors}><%= msg %></Error.error>
    </div>
    """
  end

  def input(%{type: "select"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <%!-- <.label for={@id}><%= @label %></.label> --%>
      <select
        id={@id}
        name={@name}
        class="block w-full mt-2 bg-white border border-gray-300 rounded-md shadow-sm focus:border-zinc-400 focus:ring-0 sm:text-sm"
        multiple={@multiple}
        {@rest}
      >
        <option :if={@prompt} value=""><%= @prompt %></option>
        <%= Phoenix.HTML.Form.options_for_select(@options, @value) %>
      </select>
      <Error.error :for={msg <- @errors}><%= msg %></Error.error>
    </div>
    """
  end


  def input(%{type: "textarea"} = assigns) do
    ~H"""
    <div phx-feedback-for={@name}>
      <%!-- <.label for={@id}><%= @label %></.label> --%>
      <textarea
        id={@id}
        name={@name}
        class={[
          "mt-2 block w-full rounded-lg text-zinc-900 focus:ring-0 sm:text-sm sm:leading-6",
          "min-h-[6rem] phx-no-feedback:border-zinc-300 phx-no-feedback:focus:border-zinc-400",
          @errors == [] && "border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400"
        ]}
        {@rest}
      ><%= Phoenix.HTML.Form.normalize_value("textarea", @value) %></textarea>
      <Error.error :for={msg <- @errors}><%= msg %></Error.error>
    </div>
    """
  end

  def input(%{variant: "default"} = assigns) do
    ~H"""
    <div>
      <label for={@id} class="block mb-2 text-sm font-medium dark:text-white"><%= @label %></label>
     <div class="flex rounded-lg w-full">
     <div class="md:px-4 px-2 inline-flex items-center min-w-fit rounded-s-md border border-e-0 border-gray-200 bg-gray-50 dark:bg-neutral-700 dark:border-neutral-600">
             <span class="text-xs md:text-sm text-gray-500 dark:text-neutral-400"> <%= @prefix %> </span>
           </div>
     <div class="relative w-full">
       <input
         type={@type}
         name={@name}
         id={@id}
         value={Phoenix.HTML.Form.normalize_value(@type, @value)}
         {@rest}
         placeholder={@placeholder}
         class={[
           "py-3 px-4 block w-full rounded-lg text-sm disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:text-neutral-400 dark:placeholder-neutral-500
           dark:focus:ring-neutral-600 dark:border-neutral-700 border-gray-200 focus:border-blue-500 focus:ring-blue-500 #{@class}",
           @errors != [] &&
             "border-red-500 focus:border-red-500 focus:ring-red-300",
           (@errors == [] && @used) && "border-teal-500 focus:border-teal-500 focus:ring-teal-500", @icon != "hero-" && "sm:ps-11", @prefix && "!rounded-l-none",
           @suffix && "!rounded-r-none"
         ]}
       />
       <div class="hidden absolute inset-y-0 start-0 sm:flex items-center pointer-events-none z-20 ps-4" >
               <LibraryWeb.CoreComponents.icon name={@icon} class="shrink-0 h-4 w-4 text-gray-400 dark:text-neutral-600" />
             </div>
       <div
         :if={@errors != []}
         class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
         :if={@errors == [] && @used}
         class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
     <.link :if={@suffix} patch={@suffix.navigate} class="px-1 shrink-0 inline-flex justify-center items-center gap-x-2 text-sm font-semibold rounded-e-md border border-transparent bg-blue-600 text-white hover:bg-blue-700 focus:outline-none focus:bg-blue-700 disabled:opacity-50 disabled:pointer-events-none">
     <LibraryWeb.CoreComponents.icon :if={Map.has_key?(@suffix, :icon)} name={@suffix.icon} class="shrink-0 h-4 w-4" /> <%= if Map.has_key?(@suffix, :label), do: @suffix.label %>
           </.link>
      </div>

      <Error.error :for={msg <- @errors}>
        <%= msg %>
      </Error.error>
      <%= if @errors == [] && @used do %>
        <p class="text-sm text-teal-600 mt-2" id="hs-validation-name-success-helper"> <%= @msg %> </p>
        <% end %>
    </div>
    """
  end

  def input(%{variant: "gray"} = assigns) do
    ~H"""
    <div>
    <div class="flex justify-between">
      <label class="block mb-2 text-sm font-medium dark:text-white" for={@id}><%= @label %></label>
        <span :if={@hint} class="block mb-2 text-sm text-gray-500 dark:text-neutral-500"> <%= @hint %> </span>
    </div>
      <div class="relative">
        <input
          value={Phoenix.HTML.Form.normalize_value(@type, @value)}
          id={@id}
          name={@name}
          type={@type}
          placeholder={@placeholder}
          class={[
            "peer disabled:opacity-50 disabled:pointer-events-none focus:border-blue-500
            focus:ring-blue-500 border-transparent dark:placeholder-neutral-500 dark:focus:ring-neutral-600
            w-full block px-4 py-3 text-sm rounded-lg bg-gray-100
            dark:bg-neutral-700 dark:text-neutral-400 #{@class}",
            @icon && "ps-11", (@errors == [] && @used) && "bg-teal-100/50", @errors != [] && "bg-red-100/50"
          ]}
          {@rest}
        />
        <div
          :if={@icon}
          class="absolute inset-y-0 flex items-center pointer-events-none start-0 ps-4 peer-disabled:opacity-50 peer-disabled:pointer-events-none"
        >
          <LibraryWeb.CoreComponents.icon class="text-gray-500 dark:text-neutral-500" name={@icon} />
        </div>
        <div
          :if={@errors != []}
          class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
          :if={@errors == [] && @used}
          class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
      <p :if={@helper} class="mt-2 text-sm text-gray-500 dark:text-neutral-500" id="input-helper-text"> <%= @helper %> </p>
      <Error.error :for={msg <- @errors}>
        <%= msg %>
      </Error.error>
      <%= if @errors == [] && @used do %>
          <p class="text-sm text-teal-600 mt-2"
        id="success-helper"> <%= @msg %> </p>
        <% end %>
    </div>
    """
  end

  def input(%{variant: "underline"}= assigns) do
    ~H"""
    <div class="relative">
      <div class="relative">
        <input
          value={Phoenix.HTML.Form.normalize_value(@type, @value)}
          id={@id}
          {@rest}
          name={@name}
          type={@type}
          placeholder={@placeholder}
          class={[
            "peer w-full py-3 ps-8 pe-10 bg-transparent border-t-transparent
            border-b-2 border-x-transparent border-b-gray-200 text-sm focus:border-t-transparent
            focus:border-x-transparent focus:border-b-blue-500 focus:ring-0 disabled:opacity-50
            disabled:pointer-events-none dark:border-b-neutral-700 dark:text-neutral-400 dark:placeholder-neutral-500
            dark:focus:ring-neutral-600 dark:focus:border-b-neutral-600 #{@class}",
            (@errors == [] && @used) && "focus:!border-b-teal-500 !border-b-teal-300",
            @errors != [] && "bg-red-100/50 focus:!border-b-red-400 !border-b-red-300"
          ]}
          {@rest}
        />
        <div class="absolute inset-y-0 start-0 flex items-center pointer-events-none ps-2 peer-disabled:opacity-50 peer-disabled:pointer-events-none">
        <LibraryWeb.CoreComponents.icon class="shrink-0 h-4 w-4 text-gray-500 dark:text-neutral-500" name={@icon}/>
        </div>
        <div :if={@errors != []} class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3">
          <svg class="flex-shrink-0 w-5 h-5 text-red-500" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10" /><line x1="12" x2="12" y1="8" y2="12" /><line x1="12" x2="12.01" y1="16" y2="16" />
          </svg>
        </div>
        <div :if={@errors == [] && @used} class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3">
          <svg class="flex-shrink-0 w-4 h-4 text-teal-500" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12" />
          </svg>
        </div>
      </div>

      <p :if={@helper} class="mt-2 text-sm text-gray-500 dark:text-neutral-500" id="input-helper-text"><%= @helper %></p>
      <Error.error :for={msg <- @errors}>
        <%= msg %>
      </Error.error>
      <%= if @errors == [] && @used do %>
        <p class="text-sm text-teal-600 mt-2" id="success-helper"><%= @msg %></p>
      <% end %>
    </div>
    """
  end

  def input(%{variant: "floating"} = assigns) do
    ~H"""
    <div>
      <div class="relative">
        <input
          value={Phoenix.HTML.Form.normalize_value(@type, @value)}
          id={@id}
          {@rest}
          name={@name}
          type={@type}
          placeholder={@placeholder}
          class={[
            "peer p-4 block w-full border-gray-200 rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-900 dark:border-neutral-700 dark:text-neutral-400 dark:focus:ring-neutral-600
                focus:pt-6
                focus:pb-2
                [&:not(:placeholder-shown)]:pt-6
                [&:not(:placeholder-shown)]:pb-2
                autofill:pt-6
                autofill:pb-2 #{@class}",
            (@errors == [] && @used) &&
              "focus:!border-teal-500 !border-teal-300 focus:!ring-teal-300",
            @errors != [] &&
              "focus:!border-red-500 !border-red-300 focus:!ring-red-300"
          ]}
        />
        <label
          for={@id}
          class="absolute top-0 start-0 p-4 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent  origin-[0_0] dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none
                peer-focus:scale-90
                peer-focus:translate-x-0.5
                peer-focus:-translate-y-1.5
                peer-focus:text-gray-500 dark:peer-focus:text-neutral-500
                peer-[:not(:placeholder-shown)]:scale-90
                peer-[:not(:placeholder-shown)]:translate-x-0.5
                peer-[:not(:placeholder-shown)]:-translate-y-1.5
                peer-[:not(:placeholder-shown)]:text-gray-500 dark:peer-[:not(:placeholder-shown)]:text-neutral-500 dark:text-neutral-500"
        >
          <%= @label %>
        </label>
        <div
          :if={@errors != []}
          class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
          :if={@errors == [] && @used}
          class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
      <p :if={@helper} class="mt-2 text-sm text-gray-500 dark:text-neutral-500" id="input-helper-text"><%= @helper %></p>
      <Error.error :for={msg <- @errors}>
        <%= msg %>
      </Error.error>
      <%= if @errors == [] && @used do %>
        <p class="text-sm text-teal-600 mt-2" id="success-helper"><%= @msg %></p>
      <% end %>
    </div>
    """
  end

  def input(%{variant: "floating-gray"} = assigns) do
      ~H"""
      <div>
        <div class="relative">
          <input
            value={Phoenix.HTML.Form.normalize_value(@type, @value)}
            id={@id}
            {@rest}
            name={@name}
            type={@type}
            placeholder={@placeholder}
            class={[
              "peer p-4 block w-full bg-gray-100 border-transparent rounded-lg text-sm placeholder:text-transparent focus:border-blue-500 focus:ring-blue-500 disabled:opacity-50 disabled:pointer-events-none dark:bg-neutral-700 dark:border-transparent dark:text-neutral-400 dark:focus:ring-neutral-600
                  focus:pt-6
                  focus:pb-2
                  [&:not(:placeholder-shown)]:pt-6
                  [&:not(:placeholder-shown)]:pb-2
                  autofill:pt-6
                  autofill:pb-2 #{@class}",
              (@errors == [] && @used) &&
                "bg-teal-100/50",
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
            class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
            :if={@errors == [] && @used}
            class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
        <p :if={@helper} class="mt-2 text-sm text-gray-500 dark:text-neutral-500" id="input-helper-text"><%= @helper %></p>
        <Error.error :for={msg <- @errors}>
          <%= msg %>
        </Error.error>
        <%= if @errors == [] && @used do %>
          <p class="text-sm text-teal-600 mt-2" id="success-helper"><%= @msg %></p>
        <% end %>
      </div>
      """
  end

 def input(%{variant: "floating-underline"} = assigns) do
   ~H"""
   <div>
     <div class="relative">
       <input
         value={Phoenix.HTML.Form.normalize_value(@type, @value)}
         id={@id}
         {@rest}
         name={@name}
         type={@type}
         placeholder={@placeholder}
         class={[
           "peer py-4 px-0 block w-full bg-transparent border-t-transparent border-b-2 border-x-transparent border-b-gray-200
           text-sm placeholder:text-transparent focus:border-t-transparent focus:border-x-transparent focus:border-b-blue-500
           focus:ring-0 disabled:opacity-50 disabled:pointer-events-none
           dark:border-b-neutral-700 dark:text-neutral-400 dark:focus:ring-neutral-600 dark:focus:border-b-neutral-600
                                     focus:pt-6
                                     focus:pb-2
                                     [&:not(:placeholder-shown)]:pt-6
                                     [&:not(:placeholder-shown)]:pb-2
                                     autofill:pt-6
                                     autofill:pb-2 #{@class}",
           (@errors == [] && @used) &&
             "!border-b-teal-500",
           @errors != [] &&
             "!border-b-red-500"
         ]}
       />
       <label
         for={@id}
         class="absolute top-0 start-0 py-4 px-0 h-full text-sm truncate pointer-events-none transition ease-in-out duration-100 border border-transparent  origin-[0_0] dark:text-white peer-disabled:opacity-50 peer-disabled:pointer-events-none
                                     peer-focus:scale-90
                                     peer-focus:translate-x-0.5
                                     peer-focus:-translate-y-1.5
                                     peer-focus:text-gray-500 dark:peer-focus:text-neutral-500
                                     peer-[:not(:placeholder-shown)]:scale-90
                                     peer-[:not(:placeholder-shown)]:translate-x-0.5
                                     peer-[:not(:placeholder-shown)]:-translate-y-1.5
                                     peer-[:not(:placeholder-shown)]:text-gray-500 dark:peer-[:not(:placeholder-shown)]:text-neutral-500 dark:text-neutral-500"
       >
         <%= @label %>
       </label>
       <div
         :if={@errors != []}
         class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
         :if={@errors == [] && @used}
         class="absolute inset-y-0 end-0 flex items-center pointer-events-none pe-3"
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
     <p :if={@helper} class="mt-2 text-sm text-gray-500 dark:text-neutral-500" id="input-helper-text"><%= @helper %></p>
     <Error.error :for={msg <- @errors}>
       <%= msg %>
     </Error.error>
     <%= if @errors == [] && @used do %>
       <p class="text-sm text-teal-600 mt-2" id="success-helper"><%= @msg %></p>
     <% end %>
   </div>
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
