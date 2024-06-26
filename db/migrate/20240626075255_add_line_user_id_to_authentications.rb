class AddLineUserIdToAuthentications < ActiveRecord::Migration[7.1]
  def change
    add_column :authentications, :line_user_id, :string
    add_index :authentications, [:provider, :line_user_id], unique: true
  end
end
