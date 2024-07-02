require "test_helper"

class UserpageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get userpage_index_url
    assert_response :success
  end

  test "should get login" do
    get userpage_login_url
    assert_response :success
  end
end
