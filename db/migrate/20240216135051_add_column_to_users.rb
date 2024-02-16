class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :sleep_time, :string
    add_column :users, :favorite_goods, :string
  end
end
