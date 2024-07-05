require "test_helper"

class YoutubeVideoTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:user)
    should have_many(:user_notifications)
  end

  context "validations" do
    should validate_presence_of(:url)
    should validate_presence_of(:title)
    should validate_presence_of(:thumb)
  end
end
