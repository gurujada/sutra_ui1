defmodule LibraryWeb.PostLive.LiveTable do
  use LibraryWeb, :live_component
  alias Library.Repo
  import Ecto.Query, warn: false
  import Table

  def render(assigns) do
    ~H"""
    <div>
      <div id={@id} phx-update="stream">
        <.table cols={@cols} records={@streams.rows} options={@options} changeset={@changeset} />
        <Pagination.pagination variant="lettered" options={@options} changeset={@changeset} />
      </div>
    </div>
    """
  end

  def get_records_by_query(query, options, filter) do
    query
    |> filter(filter)
    |> sort(options)
    |> paginate(options)
    |> Repo.all()
  end

  defp sort(query, %{sort_by: sort_by, sort_order: sort_order}) do
    order_by(query, {^sort_order, ^sort_by})
  end

  defp sort(query, _options), do: query

  defp paginate(query, %{page: page, per_page: per_page}) do
    offset = max((page - 1) * per_page, 0)

    query
    |> limit(^per_page)
    |> offset(^offset)
  end

  def filter(query, %{type: ""}), do: query

  def filter(query, %{type: type, value: value}) do
    where(query, [p], ilike(p.body, ^"%#{value}%"))
  end

  # def filter_by_prices(query, %{value: ""}), do: query

  # def filter_by_prices(query, %{prices: prices}) do
  #   where(query, [boat], boat.price in ^prices)
  # end
end
