# frozen_string_literal: true
require 'net/http'

class YoutubeVideoService
  attr_reader :key_rotation
  def initialize
    @key_rotation = KeyRotationService.new([
                                             ENV['YOUTUBE_API_KEY']
                                          ])
  end

  # Get youtube snippet info by youtube url
  #
  # Support two url's format: https://www.youtube.com/watch?v=xxx and https://youtu.be/xxx
  #
  # return nil if could not get anything or error
  def get_info_by_url(url)
    key = @key_rotation.get_random
    video_id = ''
    video_url = ''
    if url.include?("youtu.be/")
      video_id = URI(url).path&.delete_prefix('/')
      video_url = "https://youtu.be/#{video_id}"
    elsif url.include?("youtube.com/")
      video_id = Rack::Utils.parse_query(URI(url).query)["v"]
      video_url = "https://www.youtube.com/watch?v=#{video_id}"
    end
    # https://www.youtube.com/watch?v=vuTY4FDAbpA
    # https://youtu.be/1mkUp1V3ys0?si=yf74peN0Eou2mZCn
    if video_id.present?
      result = Net::HTTP.get(URI("https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{key}&part=snippet"))
      json = JSON.parse(result)
      data = json.try(:[], 'items')&.first.try(:[], 'snippet')
      unless data.nil?
        {
          url: video_url,
          channelId: data['channelId'],
          title: data['title'],
          thumbnail: data.try(:[], "thumbnails").try(:[], "medium").try(:[], "url"),
          description: data['description'],
        }
      end
    end
  rescue Exception => ex
    p ex
    nil
  end

  def create_video(video, current_user)
    new_video = YoutubeVideo.create_from_payload(video, current_user)
    result = new_video.save!
    if result
      uids = User.where('youtube_video_id < ? or youtube_video_id is null', new_video.id).pluck(:id)
      uids.delete(current_user.id)
      batch_insert = uids.map do |uid|
        {
          title: new_video.title,
          user_id: uid,
          youtube_video_id: new_video.id,
        }
      end
      UserNotification.insert_all!(batch_insert)
      current_user.set_last_watch_id(new_video.id)

      NotificationJob.perform_now(new_video.full_info)
    end
    result
  end

  def self.last_id
    YoutubeVideo.last&.id || 0
  end
end
