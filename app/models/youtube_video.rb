class YoutubeVideo < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :title, presence: true
  validates :thumb, presence: true
  has_many :users

  def self.create_from_payload(payload, current_user)

    title = payload[:title]
    url = payload[:url]
    thumb = payload[:thumbnail]
    description = payload[:description]

    raise 'Invalid payload' if title.nil? || title.empty? || url.nil? || url.empty? || thumb.nil? || thumb.empty? || current_user.nil?

    video = YoutubeVideo.new
    video.user = current_user
    video.url = url
    video.title = title
    video.thumb = thumb
    video.description = description

    video
  end

  def info
    {
      id: self.id,
      title: title,
      description: description,
      thumb: thumb,
      url: url,
      user_id: user_id
    }
  end
end

