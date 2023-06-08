class AddSerialToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :serial, :string
  end
end
