class AddDescriptionToYoutubeVideo < ActiveRecord::Migration[7.1]
  def change
    add_column :youtube_videos, :description, :text
  end
end
