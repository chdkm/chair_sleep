class CreateUserSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :user_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.boolean :line_notification
      t.string :line_user_id

      t.timestamps
    end
  end
end
