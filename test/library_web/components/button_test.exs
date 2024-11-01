defmodule ButtonTest do
  use ExUnit.Case
  import Phoenix.Component
  import Phoenix.LiveViewTest
  import Button

  describe "button/1" do
    test "renders basic button with default attributes" do
      html =
        render_component(&button/1,
          class: "",
          size: "md",
          variant: "solid",
          icon: nil,
          icon_position: "left",
          inner_block: fn -> "Click me" end
        )

      assert html =~ "Click me"
      assert html =~ "inline-flex"
      assert html =~ "bg-blue-600"
    end

    test "renders button with small size" do
      html =
        render_component(&button/1,
          class: "",
          size: "sm",
          variant: "solid",
          icon: nil,
          icon_position: "left",
          inner_block: fn -> "Click me" end
        )

      assert html =~ "py-2 px-3"
    end

    test "renders button with outline variant" do
      html =
        render_component(&button/1,
          class: "",
          size: "md",
          variant: "outline",
          icon: nil,
          icon_position: "left",
          inner_block: fn -> "Click me" end
        )

      assert html =~ "border-blue-600"
      assert html =~ "text-blue-600"
    end

    test "renders button with left icon" do
      html =
        render_component(&button/1,
          class: "",
          size: "md",
          variant: "solid",
          icon: %{name: "check", position: "left", class: "test-icon"},
          icon_position: "left",
          inner_block: fn -> "Click me" end
        )

      assert html =~ "test-icon"
      assert html =~ "check"
    end

    test "applies custom classes" do
      html =
        render_component(&button/1,
          class: "custom-class",
          size: "md",
          variant: "solid",
          icon: nil,
          icon_position: "left",
          inner_block: fn -> "Click me" end
        )

      assert html =~ "custom-class"
    end
  end
end
