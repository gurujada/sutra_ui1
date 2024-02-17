defmodule LibraryWeb.AvatarGroupTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  import Phoenix.Component
  import AvatarGroup

  describe "basic avatar group tests" do
    test "renders avatar group" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group avatars={[
          %{
            name: "Virinchi",
            src:
              "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
          }
        ]} />
        """)

      assert avatar_group =~ "src=\"https://www.virinchi.me/img/virinchi"

      assert avatar_group =~ "<img"
    end
    test "renders arbitrary classes" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group
          class="bg-red-500 border-blue-900"
          avatars={[
            %{
              name: "Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            }
          ]}
        />
        """)

      assert avatar_group =~ "bg-red-500"
      assert avatar_group =~ "border-blue-900"
    end
    test "renders max limit" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group
limit={1}
          avatars={[
            %{
              name: "Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            },
            %{
              name: "Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            },
            %{
              name: "Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            }
          ]}
        />
        """)

      assert avatar_group =~ "2"
      assert avatar_group =~ "+"
    end
    test "renders size" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group

          avatars={[
            %{
              name: "Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            }
          ]}
        />
        """)

      assert avatar_group =~ "h-11"
      assert avatar_group =~ "w-11"
    end
    test "renders placeholder" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group

          avatars={[
            %{
              name: "Chivukula Virinchi",
              src:
                ""
            }
          ]}
        />
        """)

      assert avatar_group =~ "CV"
    end

    test "renders variant" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group

          avatars={[
            %{
              name: "Chivukula Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            }
          ]}
        />
        """)

      assert avatar_group =~ "-space-x"
      refute avatar_group =~ "grid"
    end

test "renders color" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group
        color="primary"
          avatars={[
            %{
              name: "Chivukula Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            }
          ]}
        />
        """)

      assert avatar_group =~ "border-primary"
      assert avatar_group =~ "bg-primary"
    end
test "renders border" do
      assigns = %{}

      avatar_group =
        rendered_to_string(~H"""
        <.avatar_group
          avatars={[
            %{
              name: "Chivukula Virinchi",
              src:
                "https://www.virinchi.me/img/virinchi_hu922a05f833375c24fc0b469acb202f7a_6128766_288x288_fill_q75_h2_box_center_2.webp"
            }
          ]}
        />
        """)

      assert avatar_group =~ "ring"
    end

  end
end
