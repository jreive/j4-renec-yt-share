class NotificationJob < ApplicationJob
  queue_as :default

  def perform(video)
    ActionCable.server.broadcast("user", video)
  end
end
