class CreateUserNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :user_notifications do |t|
      t.string :title
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.belongs_to :youtube_video, null: false, foreign_key: true
      t.boolean :read, default: false, null: false
      t.datetime :read_at
      t.boolean :pushed, default: false, null: false
      t.datetime :pushed_at

      t.timestamps
    end
  end
end
