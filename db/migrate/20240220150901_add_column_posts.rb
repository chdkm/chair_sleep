class AddColumnPosts < ActiveRecord::Migration[7.1]
  def change
  	add_column :posts, :prepare, :string

    add_column :posts, :care, :string
  end
end
