class CreatePostTags < ActiveRecord::Migration[7.1]
  def change
    create_table :post_tags do |t|
      t.references :post, null: false, foreign_key: true
      t.references :item_tag, null: false, foreign_key: true

      t.timestamps
    end

    add_index :post_tags, [:post_id, :item_tag_id], unique: true
  end
end
