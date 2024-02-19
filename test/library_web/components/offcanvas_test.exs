defmodule LibraryWeb.OffcanvasTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  import Phoenix.Component
  import Offcanvas

  describe "basic tests" do
    test "basic offcanvas test" do
      assigns = %{}
      offcanvas = rendered_to_string(
        ~H"""
        <.offcanvas>
        <div>Lorem ipsum dolor sit amet</div>
        </.offcanvas>
        """
      )
      assert offcanvas =~ "Lorem ipsum dolor sit amet"
      assert offcanvas =~ "phx-click"
      assert offcanvas =~ "left-0"
    end

    test "offcanvas (right)" do
            assigns = %{}
      offcanvas = rendered_to_string(
        ~H"""
        <.offcanvas position="right">
        <div>Lorem ipsum dolor sit amet</div>
        </.offcanvas>
        """
      )
      assert offcanvas =~ "right-0"
      assert offcanvas =~ "absolute"
      assert offcanvas =~ "phx-click"
    end

    test "offcanvas (top)" do
            assigns = %{}
      offcanvas = rendered_to_string(
        ~H"""
        <.offcanvas position="top">
        <div>Lorem ipsum dolor sit amet</div>
        </.offcanvas>
        """
      )
      assert offcanvas =~ "w-full"
      assert offcanvas =~ "inset-x-0"
      assert offcanvas =~ "absolute"
      assert offcanvas =~ "phx-click"
    end
    test "offcanvas (bottom)" do
            assigns = %{}
      offcanvas = rendered_to_string(
        ~H"""
        <.offcanvas position="bottom">
        <div>Lorem ipsum dolor sit amet</div>
        </.offcanvas>
        """
      )
      assert offcanvas =~ "w-full"
      assert offcanvas =~ "inset-x-0"
      assert offcanvas =~ "absolute"
      assert offcanvas =~ "phx-click"
    end

    test "arbitrary attrs" do
      assigns = %{}
      offcanvas = rendered_to_string(
        ~H"""
        <.offcanvas class="bg-black">
        <div>Lorem ipsum dolor sit amet</div>

        </.offcanvas>
        """
      )
      assert offcanvas =~ "bg-black"
    end

  end

end
