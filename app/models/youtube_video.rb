class YoutubeVideo < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :title, presence: true
  validates :thumb, presence: true
  has_many :users

  def self.create_from_payload(payload)
    title = payload["title"]

    raise 'Invalid payload' if title.nil? || title.empty?


    payload["thumbnails"]
    payload["thumbnails"]["medium"]
    payload["thumbnails"]["medium"]["url"]
    payload["thumbnails"]["medium"]["url"].length > 0
  end
end

