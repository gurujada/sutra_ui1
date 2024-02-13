defmodule Library.AvatarTest do

  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  import Phoenix.Component
  import Avatar
describe "avatar" do

  test "renders avatar" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
    <.avatar src="https://avatars.githubusercontent.com/u/12817388?v=4" />
    """
  )
    assert component =~ "https://avatars.githubusercontent.com/u/12817388?v=4"
  end

  test "renders avatar color(primary)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
    <.avatar color="primary" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
    """
  )
    assert component =~ "border-primary"
  end
  test "renders avatar color(secondary)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
    <.avatar color="secondary" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
    """
  )
    assert component =~ "border-secondary"
  end
  test "renders avatar color(success)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
    <.avatar color="success" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
    """
  )
    assert component =~ "border-success"
  end
  test "renders avatar color(warning)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
    <.avatar color="warning" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
    """
  )
    assert component =~ "border-warning"
  end
  test "renders avatar color(danger)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
    <.avatar color="danger" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
    """
  )
    assert component =~ "border-danger"
  end

  test "renders avatar size(xs)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar size="xs" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
      """
      )
      assert component =~ "h-8 w-8"
  end
  test "renders avatar size(sm)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar size="sm" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
      """
      )
      assert component =~ "h-10 w-10"
  end
  test "renders avatar size(md)" do
        assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar size="md" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
      """
      )
      assert component =~ "h-11 w-11"
  end
  test "renders avatar size(lg)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar size="lg" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
      """
      )
      assert component =~ "h-12 w-12"
  end
  test "renders avatar size(xl)" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar size="xl" src="https://avatars.githubusercontent.com/u/12817388?v=4" />
      """
      )
      assert component =~ "h-14 w-14"
  end

  test "renders avatar border" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar isBordered src="https://avatars.githubusercontent.com/u/12817388?v=4" />
      """
    )
    assert component =~ "border-3"
  end

  test "renders avatar initials & color" do
    assigns = %{}
    component  = rendered_to_string(
      ~H"""
      <.avatar color="primary" isBordered placeholder="Chivukula Virinchi" />
      """
    )
    assert component =~ "CV"
    assert component =~ "bg-primary border-primary"
  end
end
end
