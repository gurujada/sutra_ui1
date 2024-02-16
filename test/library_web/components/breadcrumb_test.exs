defmodule Library.BreadcrumbTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  import Phoenix.Component
  import Breadcrumb

  describe "basic breadcrumb tests" do
    test "basic usage" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb links={[
          %{label: "Link 1", to: "https://www.virinchi.me"}
        ]}>
        </.breadcrumb>
        """)

      assert component =~ "Link 1"
      assert component =~ "<a"
      assert component =~ "href"
      assert component =~ "www.virinchi.me"
    end

    test "arbitrary attributes" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb
          class="bg-primary"
          links={[
            %{label: "Link 1", to: ""}
          ]}
        >
        </.breadcrumb>
        """)

      assert component =~ "bg-primary"
    end

    test "link_class" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb
          link_class="mt-8"
          links={[
            %{label: "Link 1", to: ""}
          ]}
        >
        </.breadcrumb>
        """)

      assert component =~ "mt-8"
    end

    test "separator(slash)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb
          separator="slash"
          links={[
            %{label: "Link 1", to: ""},
            %{label: "Link 1", to: ""}
          ]}
        >
        </.breadcrumb>
        """)

      # Path for slash
      assert component =~ "<path d=\"M6 13L10 3\""
    end

    test "separator(arrow)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb links={[
          %{label: "Link 1", to: ""},
          %{label: "Link 2", to: ""}
        ]}>
        </.breadcrumb>
        """)

      # Path for arrow
      assert component =~ "<path d=\"m9 18 6-6-6-6\">"
    end

    test "icon test" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb links={[
          %{label: "Link 1", to: "", icon: "hero-user-solid"},
          %{label: "Link 2", to: ""}
        ]}>
        </.breadcrumb>
        """)

      # Path for hero-user-solid
      assert component =~ "d=\"M7.5 6a4.5 4.5 0"
    end
  end

  describe "breadcrumb methods" do
    test "method link_type(a)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb links={[
          %{label: "Link 1", to: "", link_type: "a", icon: "hero-user-solid"},
          %{label: "Link 2", to: "", link_type: "a"}
        ]}>
        </.breadcrumb>
        """)

      assert component =~ "<a href=\"\""
    end

    test "method link_type(live_patch)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb links={[
          %{label: "Link 1", to: "", icon: "hero-user-solid"},
          %{label: "Link 2", to: ""}
        ]}>
        </.breadcrumb>
        """)

      assert component =~ "<a href=\"/\" data-phx-link=\"patch\" data-phx-link-state=\"push\""
    end

    test "method link_type(navigate)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.breadcrumb links={[
          %{label: "Link 1", to: "", link_type: "navigate", icon: "hero-user-solid"},
          %{label: "Link 2", to: "", link_type: "navigate"}
        ]}>
        </.breadcrumb>
        """)

      assert component =~ "<a href=\"/\" data-phx-link=\"redirect\" data-phx-link-state=\"push\""
    end
  end
end
