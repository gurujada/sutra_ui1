defmodule Library.ButtonTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  import Phoenix.Component
  import LibraryWeb.Button

  describe "basic button tests" do
    test "renders button" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button>Click me</.button>
        """)

      assert component =~ "<button"
      assert component =~ "Click me"
    end

    test "renders button class" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button class="bg-primary">Click me</.button>
        """)

      assert component =~ "bg-primary"
    end

    test "arbitrary attrs" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button disabled>Click me</.button>
        """)

      assert component =~ "disabled"
    end
  end

  describe "button type tests" do
    test "button type (a)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="a" to="">Button</.button>
        """)

      assert component =~ "<a href=\"\""
    end

    test "button type (live_patch)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="live_patch" to="">Button</.button>
        """)

      assert component =~ "<a href=\"/\" data-phx-link=\"patch\" data-phx-link-state=\"push\""
    end

    test "button type (button)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="button">Button</.button>
        """)

      assert component =~ "<button class=\""
    end

    test "button type (navigate)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="navigate">Click me</.button>
        """)

      assert component =~ "<a href=\"/\" data-phx-link=\"redirect\" data-phx-link-state=\"push\""
    end
  end

  describe "button radius tests" do
    test "button size(sm)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button size="sm">Click me</.button>
        """)

      assert component =~ "py-2"
    end

    test "button size(md)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button size="md">Click me</.button>
        """)

      assert component =~ "py-3"
    end

    test "button size(lg)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button size="lg">Click me</.button>
        """)

      assert component =~ "p-4"
    end

    test "button radius(xs)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="xs">Click me</.button>
        """)

      assert component =~ "rounded-xs"
    end

    test "button radius(sm)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="sm">Click me</.button>
        """)

      assert component =~ "rounded-sm"
    end

    test "button radius(md)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="md">Click me</.button>
        """)

      assert component =~ "rounded-md"
    end

    test "button radius(lg)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="lg">Click me</.button>
        """)

      assert component =~ "rounded-lg"
    end

    test "button radius(xl)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="xl">Click me</.button>
        """)

      assert component =~ "rounded-xl"
    end

    test "button radius(full)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="full">Click me</.button>
        """)

      assert component =~ "rounded-full"
    end

    test "button radius(none)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button radius="none">Click me</.button>
        """)

      assert component =~ "rounded-none"
    end
  end

  describe "button + icon tests" do
    test "renders only icon(button)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="button">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
        </.button>
        """)

      assert component =~ "<svg"
    end

    test "renders only icon(live_patch)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="live_patch">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
        </.button>
        """)

      assert component =~ "<svg"
    end

    test "renders only icon(navigate)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="navigate">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
        </.button>
        """)

      assert component =~ "<svg"
    end

    test "renders only icon(a)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="a">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
        </.button>
        """)

      assert component =~ "<svg"
    end

    test "renders icon with label(button)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="button">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click me
        </.button>
        """)

      assert component =~ "<svg"
      assert component =~ "Click me"
    end

    test "renders icon with label(live_patch)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="live_patch">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click me
        </.button>
        """)

      assert component =~ "<svg"
      assert component =~ "Click me"
    end

    test "renders icon with label(navigate)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="navigate">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click me
        </.button>
        """)

      assert component =~ "<svg"
      assert component =~ "Click me"
    end

    test "renders icon with label(a)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button link_type="a">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click me
        </.button>
        """)

      assert component =~ "<svg"
      assert component =~ "Click me"
    end

    test "icon is rendered on the left side correctly(button)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button link_type="button">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert left_of_content =~ "<svg"
      refute right_of_content =~ "<svg"
    end

    test "icon is rendered on the right side correctly(button)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button icon_position="right" link_type="button">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert right_of_content =~ "<svg"
      refute left_of_content =~ "<svg"
    end

    test "icon is rendered on the left side correctly(a)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button link_type="a">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert left_of_content =~ "<svg"
      refute right_of_content =~ "<svg"
    end

    test "icon is rendered on the right side correctly(a)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button icon_position="right" link_type="a">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert right_of_content =~ "<svg"
      refute left_of_content =~ "<svg"
    end

    test "icon is rendered on the left side correctly(live_patch)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button link_type="live_patch">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert left_of_content =~ "<svg"
      refute right_of_content =~ "<svg"
    end

    test "icon is rendered on the right side correctly(live_patch)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button icon_position="right" link_type="live_patch">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert right_of_content =~ "<svg"
      refute left_of_content =~ "<svg"
    end

    test "icon is rendered on the left side correctly(navigate)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button link_type="navigate">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert left_of_content =~ "<svg"
      refute right_of_content =~ "<svg"
    end

    test "icon is rendered on the right side correctly(navigate)" do
      assigns = %{}

      markup =
        rendered_to_string(~H"""
        <.button icon_position="right" link_type="navigate">
          <:icon>
            <svg
              class="flex-shrink-0 w-5 h-5"
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <path d="m5 11 4-7" /><path d="m19 11-4-7" /><path d="M2 11h20" /><path d="m3.5 11 1.6 7.4a2 2 0 0 0 2 1.6h9.8c.9 0 1.8-.7 2-1.6l1.7-7.4" /><path d="m9 11 1 9" /><path d="M4.5 15.5h15" /><path d="m15 11-1 9" />
            </svg>
          </:icon>
          Click
        </.button>
        """)

      [left_of_content, right_of_content] = String.split(markup, "Click")
      assert right_of_content =~ "<svg"
      refute left_of_content =~ "<svg"
    end
  end

  describe "button color tests" do
    test "color(primary)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button color="primary">Click me</.button>
        """)

      assert component =~ "bg-primary"
    end

    test "color(secondary)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button color="secondary">Click me</.button>
        """)

      assert component =~ "bg-secondary"
    end

    test "color(success)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button color="success">Click me</.button>
        """)

      assert component =~ "bg-success"
    end

    test "color(warning)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button color="warning">Click me</.button>
        """)

      assert component =~ "bg-warning"
    end

    test "color(danger)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button color="danger">Click me</.button>
        """)

      assert component =~ "bg-danger"
    end
  end

  describe "button variant tests" do
    test "variant(solid)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button variant="solid">Click me</.button>
        """)

      assert component =~ "bg-gray-900"
    end

    test "variant(outline)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button variant="outline">Click me</.button>
        """)

      assert component =~ "border"
    end

    test "variant(soft)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button variant="soft">Click me</.button>
        """)

      assert component =~ "bg-gray-100"
    end

    test "variant(ghost)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button variant="ghost">Click me</.button>
        """)

      assert component =~ "hover:bg-gray-200"
    end

    test "variant(shadow)" do
      assigns = %{}

      component =
        rendered_to_string(~H"""
        <.button variant="shadow">Click me</.button>
        """)

      assert component =~ "shadow-md"
    end
  end
end
