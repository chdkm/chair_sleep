class AddPostIdToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :post, foreign_key: true, null: false
    add_reference :items, :user, foreign_key: true, null: false
  end
end
