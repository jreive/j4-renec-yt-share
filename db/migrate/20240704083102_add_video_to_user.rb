class AddVideoToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :youtube_video, index: true, foreign_key: true
    remove_column :users, :video_index
  end
end
