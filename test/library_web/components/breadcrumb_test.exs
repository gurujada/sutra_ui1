defmodule LibraryWeb.BreadcrumbTest do
  use LibraryWeb.ConnCase
  import Phoenix.LiveViewTest
  import Phoenix.Component
import Breadcrumb
  describe "breadcrumb/1" do
    test "renders a basic breadcrumb trail" do
      links = [
        %{to: "/", label: "Home"},
        %{to: "/books", label: "Books"},
        %{to: "/books/1", label: "Book Details"}
      ]

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          id: "breadcrumb"
        })

      # Test for the presence of labels in the rendered HTML
      assert html =~ "Home"
      assert html =~ "Books"
      assert html =~ "Book Details"

      # Test for the presence of links
      assert html =~ ~s{href="/"}
      assert html =~ ~s{href="/books"}
      assert html =~ ~s{href="/books/1"}
    end

    test "renders with custom class" do
      links = [%{to: "/", label: "Home"}]
      custom_class = "custom-class"

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          class: custom_class,
          id: "breadcrumb"
        })

      assert html =~ custom_class
    end

    test "renders with custom link class" do
      links = [%{to: "/", label: "Home"}]
      custom_link_class = "custom-link-class"

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          link_class: custom_link_class,
          id: "breadcrumb"
        })

      assert html =~ custom_link_class
    end

    test "renders with slash separator" do
      links = [
        %{to: "/", label: "Home"},
        %{to: "/books", label: "Books"}
      ]

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          separator: "slash",
          id: "breadcrumb"
        })

      # Verify slash separator path is present
      assert html =~ ~s{<path d="M6 13L10 3"}
    end

    test "renders with arrow separator" do
      links = [
        %{to: "/", label: "Home"},
        %{to: "/books", label: "Books"}
      ]

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          separator: "arrow",
          id: "breadcrumb"
        })

      # Verify arrow separator path is present
      assert html =~ ~s{<path d="m9 18 6-6-6-6"}
    end

    test "renders with icons when provided" do
      links = [
        %{to: "/", label: "Home", icon: "hero-home"},
        %{to: "/books", label: "Books", icon: "hero-book"}
      ]

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          id: "breadcrumb"
        })

      # Verify icons are present
      assert html =~ "hero-home"
      assert html =~ "hero-book"
    end

    test "applies special styling to last item" do
      links = [
        %{to: "/", label: "Home"},
        %{to: "/books", label: "Last"}
      ]

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          id: "breadcrumb"
        })

      assert html =~ "font-semibold"
      assert html =~ "cursor-default"
    end

    test "accepts and renders arbitrary HTML attributes" do
      links = [%{to: "/", label: "Home"}]

      html =
        render_component(&breadcrumb/1, %{
          links: links,
          name: "test-name",
          rel: "nofollow",
          id: "breadcrumb"
        })

      assert html =~ ~s{name="test-name"}
      assert html =~ ~s{rel="nofollow"}
    end

    test "raises when links are not provided" do
      assert_raise KeyError, ~r/key :links not found/, fn ->
        render_component(&Breadcrumb.breadcrumb/1, %{
          id: "breadcrumb"
        })
      end
    end
  end
end
