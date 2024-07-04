class RemoveColumnHtmlOfYoutubeVideo < ActiveRecord::Migration[7.1]
  def change
    remove_column :youtube_videos, :html
  end
end
