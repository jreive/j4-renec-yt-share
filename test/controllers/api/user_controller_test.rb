require "test_helper"

class Api::UserControllerTest < ActionDispatch::IntegrationTest
  test "should get validate" do
    get api_user_validate_url
    assert_response :success
  end

  test "should get login" do
    get api_user_login_url
    assert_response :success
  end

  test "should get logout" do
    get api_user_logout_url
    assert_response :success
  end

  test "should get register" do
    get api_user_register_url
    assert_response :success
  end
end
