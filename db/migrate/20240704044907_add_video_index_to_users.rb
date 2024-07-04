class AddVideoIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :video_index, :integer, default: 0
  end
end
