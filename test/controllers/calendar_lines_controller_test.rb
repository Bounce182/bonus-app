require 'test_helper'

class CalendarLinesControllerTest < ActionController::TestCase
  setup do
    @calendar_line = calendar_lines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:calendar_lines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create calendar_line" do
    assert_difference('CalendarLine.count') do
      post :create, calendar_line: { date: @calendar_line.date, user_id: @calendar_line.user_id }
    end

    assert_redirected_to calendar_line_path(assigns(:calendar_line))
  end

  test "should show calendar_line" do
    get :show, id: @calendar_line
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @calendar_line
    assert_response :success
  end

  test "should update calendar_line" do
    patch :update, id: @calendar_line, calendar_line: { date: @calendar_line.date, user_id: @calendar_line.user_id }
    assert_redirected_to calendar_line_path(assigns(:calendar_line))
  end

  test "should destroy calendar_line" do
    assert_difference('CalendarLine.count', -1) do
      delete :destroy, id: @calendar_line
    end

    assert_redirected_to calendar_lines_path
  end
end
