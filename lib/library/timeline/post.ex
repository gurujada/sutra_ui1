defmodule Library.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :likes_count, :integer
    field :repost_count, :integer
    field :photo_locations, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :likes_count, :repost_count, :photo_locations])
    |> validate_required([:body])
  end
end
