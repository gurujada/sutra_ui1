defmodule LibraryWeb.AvatarTest do
  use ExUnit.Case
  import Phoenix.Component
  import Phoenix.LiveViewTest
  import Avatar

  describe "avatar/1" do
    test "renders avatar with default values" do
      html =
        render_component(&avatar/1, %{
          src: "",
          size: "md",
          class: "",
          border: false,
          placeholder: nil,
          status: false
        })

      assert html =~ "inline-block"
      assert html =~ "svg"
    end

    test "renders image when src is provided" do
      image_url = "https://example.com/avatar.jpg"
      html = render_component(&avatar/1, %{src: image_url})

      assert html =~ image_url
      assert html =~ "<img"
    end

    test "renders initials when placeholder is provided without src" do
      html = render_component(&avatar/1, %{src: "", placeholder: "John Doe"})

      assert html =~ "JD"
    end

    test "generates correct initials for single word names" do
      html = render_component(&avatar/1, %{src: "", placeholder: "John"})

      assert html =~ "JO"
    end

    test "renders status indicator when status is true" do
      html = render_component(&avatar/1, %{status: true})

      assert html =~ "ring-white"
      assert html =~ "bg-blue-400"
    end

    test "applies different sizes correctly" do
      for size <- ["xs", "sm", "md", "lg"] do
        html = render_component(&avatar/1, %{size: size})
        expected_size_class = size(size)

        assert html =~ expected_size_class
      end
    end

    test "accepts and applies custom classes" do
      custom_class = "custom-test-class"
      html = render_component(&avatar/1, %{class: custom_class})

      assert html =~ custom_class
    end

    test "prioritizes src over placeholder" do
      html =
        render_component(&avatar/1, %{
          src: "https://example.com/avatar.jpg",
          placeholder: "John Doe"
        })

      assert html =~ "https://example.com/avatar.jpg"
      refute html =~ "JD"
    end

    # test "handles empty placeholder gracefully" do
    #   html = render_component(&avatar/1, %{src: "", placeholder: ""})

    #   assert html =~ "svg"  # Should show default avatar
    # end

    test "applies correct status indicator size based on avatar size" do
      for size <- ["xs", "sm", "md", "lg"] do
        html = render_component(&avatar/1, %{size: size, status: true})
        expected_status_size = status_size(size)

        assert html =~ expected_status_size
      end
    end
  end

  describe "initials generation" do
    test "generates correct initials for various name formats" do
      test_cases = [
        {"John Doe", "JD"},
        {"John", "JO"},
        {"Mary Jane Watson", "MW"},
        {"Smith", "SM"}
      ]

      for {input, expected} <- test_cases do
        html = render_component(&avatar/1, %{src: "", placeholder: input})
        assert html =~ expected
      end
    end
  end
end
