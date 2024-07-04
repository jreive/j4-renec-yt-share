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
    videos = YoutubeVideo.order(id: :desc)
                .paginate(per_page: payload[:limit] || 10, page: payload[:page] || 1).to_a
    if !videos.empty? && current_user.video_index < videos.first.id
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
      new_video = YoutubeVideo.new
      new_video.user = current_user
      new_video.url = url
      new_video.title = video[:title]
      new_video.thumb = video[:thumbnail]
      if new_video.save!
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
    videos = YoutubeVideo.where('id > ?', current_user.video_index).order(created_at: :desc)
    unless videos.empty?
      current_user.set_last_watch_id(videos.last.id)
    end
    response_status('Success', 200, false, data: videos)
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end

  # Save which last video user viewed
  def watched
    last_id = params.require(:last_id)
    current_user.set_last_watch_id(last_id)
    response_status
  rescue ActiveRecord::ActiveRecordError, StandardError => e
    response_status(e.message, 500, true)
  end

end
