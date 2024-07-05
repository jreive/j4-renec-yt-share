# frozen_string_literal: true

FactoryBot.define do
  factory :user_admin do
    id { 1 }
    email { "admin@mail.com" }
    youtube_video_id { nil }
  end
end