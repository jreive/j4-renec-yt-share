require "test_helper"

class UserNotificationTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should belong_to(:youtube_video)
  end

  context "validations" do
    should validate_presence_of(:title)

    should allow_value(true).for(:read)
    should allow_value(false).for(:read)
    should allow_value(nil).for(:read)

    should allow_value(true).for(:pushed)
    should allow_value(false).for(:pushed)
    should allow_value(nil).for(:pushed)
  end

end
