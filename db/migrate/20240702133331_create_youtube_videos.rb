class CreateYoutubeVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :youtube_videos do |t|
      t.string :url, null: false
      t.string :title, null: false
      t.text :html, null: false
      t.string :thumb
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.timestamps
    end

    # add_index :youtube_videos, :url, unique: true
  end
end
