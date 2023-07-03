class AddClientIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :client_id, :integer
    add_index :users, :client_id
  end
end
