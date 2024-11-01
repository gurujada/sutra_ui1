defmodule ChipTest do
  use ExUnit.Case
  import Phoenix.LiveViewTest
  import Chip

  describe "chip/1" do
    test "renders basic chip with label" do
      html =
        render_component(&chip/1, %{
          label: "Test Chip"
        })

      assert html =~ "Test Chip"
      assert html =~ ~s(class="inline-flex)
    end

    test "renders different variants correctly" do
      variants = ["solid", "outline", "soft", "white"]

      for variant <- variants do
        html =
          render_component(&chip/1, %{
            label: "Test Chip",
            variant: variant
          })

        # Each variant should have specific classes
        case variant do
          "solid" ->
            assert html =~ "bg-blue-600"

          "outline" ->
            assert html =~ "border-blue-600"

          "soft" ->
            assert html =~ "bg-blue-100"

          "white" ->
            assert html =~ "bg-white"
        end
      end
    end

    test "renders with left icon" do
      html =
        render_component(&chip/1, %{
          label: "Test Chip",
          icon: %{name: "hero-user", position: "left"}
        })

      assert html =~ "hero-user"
    end

    test "renders with right icon" do
      html =
        render_component(&chip/1, %{
          label: "Test Chip",
          icon: %{name: "hero-user", position: "right"}
        })

      assert html =~ "hero-user"
    end

    test "renders dismissable chip" do
      html =
        render_component(&chip/1, %{
          label: "Dismissable Chip",
          dismissable: true
        })

      assert html =~ "hero-x-mark"
      assert html =~ ~s(aria-label="Dismiss")
    end

    test "applies custom classes" do
      html =
        render_component(&chip/1, %{
          label: "Custom Class Chip",
          class: "custom-class"
        })

      assert html =~ "custom-class"
    end

    test "generates unique internal_id" do
      html1 =
        render_component(&chip/1, %{
          label: "Chip 1"
        })

      html2 =
        render_component(&chip/1, %{
          label: "Chip 2"
        })

      [_, id1] = Regex.run(~r/id="(chip-[^"]+)"/, html1)
      [_, id2] = Regex.run(~r/id="(chip-[^"]+)"/, html2)

      assert id1 != id2
    end

    test "handles dismissable functionality" do
         html =
           render_component(&chip/1, %{
             label: "Dismissable Chip",
             dismissable: true
           })

         # Verify the dismiss button exists
         assert html =~ "phx-click"
         assert html =~ "hero-x-mark"
         assert html =~ "Dismiss"

         # The JS.hide command is serialized with the target ID
         assert html =~ ~s{phx-click=\"[[&quot;hide&quot;}
         assert html =~ ~s{&quot;to&quot;:&quot;#chip-}
       end
  end
end
