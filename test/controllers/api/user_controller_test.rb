require "test_helper"

class Api::UserControllerTest < ActionDispatch::IntegrationTest
  test "should not get validate" do
    get api_user_validate_url
    assert_response :not_found
  end
end
