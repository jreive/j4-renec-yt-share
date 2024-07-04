require "test_helper"

class UserNotificationTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:users)
    should have_many(:youtube_videos)
  end

  context "validations" do
    should validate_presence_of(:title)
    should validate_presence_of(:read)
    should allow_value(true).for(:read)
    should allow_value(false).for(:read)
    should_not allow_value(nil).for(:read)
  end

end
