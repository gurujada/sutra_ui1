defmodule Table do
  use Phoenix.Component
  use Phoenix.HTML
  use Phoenix.VerifiedRoutes, endpoint: LibraryWeb.Endpoint, router: LibraryWeb.Router

  attr :class, :string, default: ""
  attr :options, :map
  attr :changeset, :string
  attr :cols, :map
  attr :records, :list

  def table(assigns) do
    ~H"""
    <table class={["min-w-full divide-y divide-gray-200 ark:divide-gray-700", @class]} @rest>
      <thead>
        <tr>
          <%= for {key, col} <- @cols do %>
            <%= table_header({key, col}, assigns) %>
          <% end %>
        </tr>
      </thead>

      <tbody class="divide-y divide-gray-200 ark:divide-gray-700">
        <%= for {id, row} <- @records do %>
          <.link patch={~p"/posts/#{id}"}>
            <tr id={id}>
              <%= table_body(row, assigns) %>
            </tr>
          </.link>
        <% end %>
      </tbody>
    </table>
    """
  end

  def table_header({key, col}, assigns) do
    # assigns = assign(assigns, :cols, {key, col})
    params = %{
      assigns.options
      | sort_by: key,
        sort_order: next_sort_order(assigns.options.sort_order)
    }

    assigns = assign(assigns, params: params)

    ~H"""
    <th class={[
      "px-6 py-3 text-start text-xs font-medium text-gray-500 uppercase",
      Map.get(col, :class)
    ]}>
      <.link patch={~p"/#{assigns.changeset}?#{@params}"}>
        <%= Map.get(col, :label, header({key, col})) %>
        <%= sort_indicator(@params.sort_by, @params) %>
      </.link>
    </th>
    """
  end

  def table_body(row, assigns) do
    ~H"""
    <%= for {key, col} <- @cols do %>
      <td class="px-6 py-4 text-sm text-gray-800 whitespace-nowrap ark:text-gray-200">
        <%= Map.get(row, key, Map.get(col, :default)) %>
      </td>
    <% end %>
    """
  end

  def header({key, _map}) do
    key
    |> Atom.to_string()
    |> String.replace("_", " ")
    |> String.capitalize()
  end

  defp sort_indicator(column, %{sort_by: sort_by, sort_order: sort_order})
       when column == sort_by do
    case sort_order do
      :asc -> "👆"
      :desc -> "👇"
    end
  end

  def next_sort_order(sort_order) do
    case(sort_order) do
      :asc ->
        :desc

      :desc ->
        :asc
    end
  end
end
