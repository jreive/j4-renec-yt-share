class YoutubeVideo < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :title, presence: true
  validates :html, presence: true
end

