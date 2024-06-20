class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.string :image_url
      t.string :rakuten_item_id

      t.timestamps
    end
  end
end
