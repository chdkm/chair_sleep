class AddColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :user_uid, :string
  end
end
