class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, :email => true, presence: true

  has_many :youtube_videos
  belongs_to :youtube_video, optional: true

  def set_last_watch_id(id)
    if id.positive? && self.not_watch_till_id(id)
      self.youtube_video_id = id
      self.save!
    end
  end

  def not_watch_till_id(id)
    self.youtube_video_id.nil? || (self.youtube_video_id < id)
  end
end
