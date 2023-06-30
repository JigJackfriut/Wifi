class AddUpdateNeededToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :update_needed, :boolean
  end
end
