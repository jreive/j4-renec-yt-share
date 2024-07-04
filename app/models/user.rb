class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, :email => true, presence: true

  has_many :youtube_videos

  def set_last_watch_id(id)
    if self.video_index < id
      self.video_index = id
      self.save
    end
  end
end
