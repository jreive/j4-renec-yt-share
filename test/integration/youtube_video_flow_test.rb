require "test_helper"

class YoutubeVideoFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "user add video and it must exist in new list and notification to other user" do
    sign_in users(:user_random)
    get '/api/notifications'
    list_notification_first = response.parsed_body["data"]
    assert_equal 0, list_notification_first.length

    sign_in users(:user_admin)
    get '/api/videos'
    list_first = response.parsed_body["data"]
    assert_equal(2, list_first["videos"].length)

    post '/api/videos/create', params: { url: 'https://www.youtube.com/watch?v=X-GCJwz4PnY' }
    assert_response :created

    sign_in users(:user_random)
    get '/api/notifications'
    list_notification_seconds = response.parsed_body["data"]
    assert_equal 1, list_notification_seconds.length

    get '/api/videos'
    list_second = response.parsed_body["data"]
    assert_equal(3, list_second["videos"].length)
  end
end
