require "test_helper"

class NotificationFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers


  test "authenticated user read a notification" do
    sign_in users(:user_admin)
    post '/api/notifications/read', params: { id: 1 }
    assert_response :success

    get '/api/notifications'
    list = response.parsed_body
    assert_equal 2, list["data"].length

    first = list["data"].find { |d| d["id"] == 1}
    assert_not_nil first
    assert_equal true, first["read"]

    seconds = list["data"].find { |d| d["id"] == 2}
    assert_not_nil seconds
    assert_equal false, seconds["read"]
  end


  test "authenticated user read all notification" do
    sign_in users(:user_admin)
    post '/api/notifications/read-all'
    assert_response :success

    get '/api/notifications'
    list = response.parsed_body
    assert_equal 2, list["data"].length

    first = list["data"].find { |d| d["id"] == 1}
    assert_not_nil first
    assert_equal true, first["read"]

    seconds = list["data"].find { |d| d["id"] == 2}
    assert_not_nil seconds
    assert_equal true, seconds["read"]
  end

  test "redirect to home if wrong method" do
    get '/api/notifications/read'
    assert_response :success
  end
end
