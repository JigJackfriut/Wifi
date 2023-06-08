class AddMacToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :mac, :string
  end
end
