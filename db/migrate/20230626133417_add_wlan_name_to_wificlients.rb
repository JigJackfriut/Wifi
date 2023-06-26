class AddWlanNameToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :wlan_name, :string
  end
end
