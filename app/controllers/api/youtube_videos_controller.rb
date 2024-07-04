class Api::YoutubeVideosController < ApplicationController
  respond_to :json
  before_action :authenticate_user!

  @video_service = nil

  class << self
    def video_service
      @video_service ||= YoutubeVideoService.new
    end
  end

  # Use when init page
  def index
    payload = params.permit(:page, :limit)
    page = payload[:page] || 1
    videos = YoutubeVideo.order(id: :desc)
                .paginate(per_page: payload[:limit] || 10, page: page).to_a
    if page.to_i == 1 && !videos.empty? && current_user.not_watch_till_id(videos.first.id)
      current_user.set_last_watch_id(videos.first.id)
    end
    response_status('Success', 200, false, data: videos)
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end

  # Use to share a video
  def create
    url = params.require(:url)
    video = Api::YoutubeVideosController.video_service.get_info_by_url(url)
    if video.nil?
      response_status('Could not find video metadata', 422, true)
    else
      new_video = Api::YoutubeVideosController.video_service.create_video(video, current_user)
      if new_video
        return response_status('Successfully created video', 201, true)
      else
        return response_status('Could not save video', 422, true)
      end
    end
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end

  # Use to get latest un-watched video after restore connection
  def latest_video
    videos = current_user.youtube_video_id.nil? ? [] : YoutubeVideo.where('id > ?', current_user.youtube_video_id).order(created_at: :desc)
    unless videos.empty?
      current_user.set_last_watch_id(videos.last&.id || 0)
    end
    response_status('Success', 200, false, data: videos)
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end

  # Save which last video user viewed
  def watched
    last_id = params.require(:last_id)
    video = YoutubeVideo.find_by(id: last_id)
    if video.nil?
      return response_status('Could not find video', 422, true)
    end
    if current_user.set_last_watch_id(last_id)
      response_status
    else
      response_status('Could not save last watch', 422, true)
    end
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end

end
