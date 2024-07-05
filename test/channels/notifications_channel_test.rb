require "test_helper"

class NotificationsChannelTest < ActionCable::Channel::TestCase
  test "subscribes and stream for user" do
    stub_connection current_user: users(:user_admin)
    subscribe
    assert subscription.confirmed?
    assert_has_stream "user"

    # assert_has_stream_for users(:user_admin)
  end
end