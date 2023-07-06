class AddPmkChangeToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :pmk_change, :boolean
  end
end
