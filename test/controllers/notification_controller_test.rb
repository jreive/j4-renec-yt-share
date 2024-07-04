require "test_helper"

class NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch" do
    get notification_fetch_url
    assert_response :success
  end

  test "should get read" do
    get notification_read_url
    assert_response :success
  end
end
