class UserNotification < ApplicationRecord
  validates :title, presence: true

  belongs_to :user
  belongs_to :youtube_video

  def info(video_info)
    {
      id: self.id,
      title: title,
      read: read,
      pushed: pushed,
      video: video_info || youtube_video.info
    }
  end
end
