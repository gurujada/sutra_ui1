defmodule AvatarGroupTest do
  use ExUnit.Case
  import Phoenix.LiveViewTest
import AvatarGroup
  @sample_avatars [
    %{src: "avatar1.jpg", placeholder: "John Doe"},
    %{src: "avatar2.jpg", placeholder: "Jane Smith"},
    %{src: "avatar3.jpg", placeholder: "Bob Wilson"},
    %{src: "avatar4.jpg", placeholder: "Alice Brown"},
    %{src: "avatar5.jpg", placeholder: "Charlie Davis"}
  ]

  describe "stack variant" do
    test "renders correct number of avatars within limit" do
      html =
        render_component(&avatar_group/1, %{
          avatars: @sample_avatars,
          limit: 3,
          variant: "stack"
        })

      # Should show first 3 avatars
      assert count_occurrences(html, "avatar-0") == 1
      assert count_occurrences(html, "avatar-1") == 1
      assert count_occurrences(html, "avatar-2") == 1
      assert count_occurrences(html, "avatar-3") == 0
    end

    test "shows remaining count when avatars exceed limit" do
      html =
        render_component(&avatar_group/1, %{
          avatars: @sample_avatars,
          limit: 2,
          variant: "stack"
        })

      # Should show "+3" as we're showing 2 out of 5 avatars
      assert html =~ "3+"
    end

    test "applies correct spacing and stacking classes" do
      html =
        render_component(&avatar_group/1, %{
          avatars: @sample_avatars,
          variant: "stack"
        })

      assert html =~ "flex -space-x-2"
    end
  end

  describe "grid variant" do
    test "renders avatars in grid layout" do
      html =
        render_component(&avatar_group/1, %{
          avatars: @sample_avatars,
          variant: "grid"
        })

      assert html =~ "grid grid-cols-3 gap-4"
    end

    test "shows remaining count differently than stack variant" do
      html =
        render_component(&avatar_group/1, %{
          avatars: @sample_avatars,
          limit: 2,
          variant: "grid"
        })

      assert html =~ "inline-flex items-center justify-center"
      assert html =~ "3+"
    end
  end
  describe "common functionality" do
    test "respects different size options" do
      for size <- ["sm", "md", "lg"] do
        html =
          render_component(&avatar_group/1, %{
            avatars: @sample_avatars,
            size: size,
            variant: "stack"
          })

        expected_size = case size do
          "sm" -> "size-[38px]"
          "md" -> "size-[46px]"
          "lg" -> "size-[62px]"
        end

        assert html =~ expected_size
      end
    end

    test "handles empty avatar list" do
      html =
        render_component(&avatar_group/1, %{
          avatars: [],
          variant: "stack"
        })

      # Just verify it renders without error and has the basic structure
      assert html =~ ~s|<div class="flex -space-x-2|
    end

    # test "handles single avatar" do
    #   html =
    #     render_component(&avatar_group/1, %{
    #       avatars: [%{src: "avatar1.jpg", placeholder: "John Doe"}],
    #       limit: 3,
    #       variant: "stack"
    #     })

    #   # Verify one avatar is rendered
    #   assert html =~ ~s|id="avatar-0"|
    #   # Verify no "+" counter is shown (since we're under the limit)
    #   refute html =~ ~s|<span class="font-medium leading-none">|
    # end
  end

  defp count_occurrences(string, substring) do
    string
    |> String.split(substring)
    |> length()
    |> Kernel.-(1)
end

end
