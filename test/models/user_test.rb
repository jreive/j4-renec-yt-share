require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:youtube_videos)
    should have_many(:user_notifications)
  end

  context "validations" do
    should validate_presence_of(:email)
    should allow_value("user@example.com").for(:email)
    should_not allow_value("missingMail").for(:email)
  end

end
