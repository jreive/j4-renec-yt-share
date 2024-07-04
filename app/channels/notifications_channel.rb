class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user"
  end
end