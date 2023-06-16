class AddAccountIdToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :account_id, :integer
    add_index :wificlients, :account_id
  end
end
