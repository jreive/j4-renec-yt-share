class Api::NotificationController < ApplicationController
  before_action :authenticate_user!

  def fetch
    notifications = UserNotification.where(:user_id => current_user.id)
                    .order(:created_at => :desc)
                    .limit(10)
    if notifications.length == 10
      last_notification = notifications.last
      UserNotification.where(:user_id => current_user.id)
                      .where('id < ?', last_notification.id)
                      .delete_all
                      # .update_all(:read => true)
    end
    video_ids = notifications.map(&:youtube_video_id).uniq
    videos = YoutubeVideo.find(video_ids).index_by(&:id)
    processed = notifications.map do |notification|
      notification.info(videos[notification.youtube_video_id].info)
    end

    response_status('Success', 200, false, data: processed)
  end

  def read
    notification_id = params[:id]
    record = UserNotification.find(notification_id)
    if record.user_id == current_user.id && record.read == false
      record.read = true
      record.save
    end
    response_status
  end

  def read_all
    UserNotification.where(:user_id => current_user.id).update_all(:read => true)
    response_status
  end
end
