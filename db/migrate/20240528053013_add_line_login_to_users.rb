class AddLineLoginToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :line_login, :boolean
  end
end
