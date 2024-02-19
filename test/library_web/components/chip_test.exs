defmodule Library.ChipTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  import Phoenix.Component
  import Chip

  describe "basic chip tests" do
    test "basic usage" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip>This is a chip!</.chip>
        """)

      assert chip =~ "This is a chip!"
    end

    test "arbitrary attributes" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip class="bg-red-500">This is a chip!</.chip>
        """)

      assert chip =~ "bg-red-500"
    end
  end

  describe "chip size tests" do
    test "chip size (xs)" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip size="xs">Chip</.chip>
        """)

      assert chip =~ "text-xs"
    end

    test "chip size (sm)" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip size="sm">Chip</.chip>
        """)

      assert chip =~ "text-sm"
    end

    test "chip size (md)" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip>Chip</.chip>
        """)

      assert chip =~ "text-md"
    end

    test "chip size (lg)" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip size="lg">Chip</.chip>
        """)

      assert chip =~ "text-lg"
    end

    test "radius test" do
      assigns = %{}

      chip =
        rendered_to_string(~H"""
        <.chip radius="md">Chip</.chip>
        """)

      assert chip =~ "rounded-md"
    end
  end
end
