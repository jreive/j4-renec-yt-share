# frozen_string_literal: true
require 'net/http'

class YoutubeVideoService
  attr_reader :key_rotation
  def initialize
    @key_rotation = KeyRotationHelper.new([
                                            'AIzaSyA-0vvnaLGhVFy1TNe819OAXW663E9DWzM'
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
    if url.include?("youtu.be/")
      video_id = URI(url).path&.delete_prefix('/')
    elsif url.include?("youtube.com/")
      video_id = Rack::Utils.parse_query(URI(url).query)["v"]
    end
    # https://www.youtube.com/watch?v=vuTY4FDAbpA
    # https://youtu.be/1mkUp1V3ys0?si=yf74peN0Eou2mZCn
    if video_id.present?
      result = Net::HTTP.get(URI("https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&key=#{key}&part=snippet"))
      json = JSON.parse(result)
      data = json.try(:[], 'items')&.first.try(:[], 'snippet')
      unless data.nil?
        {
          channelId: data['channelId'],
          title: data['title'],
          thumbnail: data.try(:[], "thumbnails").try(:[], "medium").try(:[], "url")
        }
      end
    end
  rescue Exception => ex
    p ex
    nil
  end

  def self.last_id
    YoutubeVideo.last&.id || 0
  end
end
