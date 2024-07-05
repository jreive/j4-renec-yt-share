require "test_helper"

module ApplicationCable
  class ConnectionTest < ActionCable::Connection::TestCase
    include ActionCable::TestHelper
    include Devise::Test::IntegrationHelpers

    test "connects with devise" do
      user = users(:user_admin)
      sign_in user
      connect_with_user(user)
      assert_equal connection.current_user, user
    end

    private

    def connect_with_user(user)
      connect env: { 'warden' => FakeEnv.new(user) }
    end

    class FakeEnv
      attr_reader :user
      def initialize(user)
        @user = user
      end
    end
  end
end
