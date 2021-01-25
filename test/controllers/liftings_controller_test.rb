require 'test_helper'

class LiftingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get liftings_show_url
    assert_response :success
  end

  test "should get new" do
    get liftings_new_url
    assert_response :success
  end

  test "should get edit" do
    get liftings_edit_url
    assert_response :success
  end

end
