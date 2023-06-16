class RemoveOwneridFromWificlients < ActiveRecord::Migration[7.0]
  def change
    remove_column :wificlients, :ownerid, :decimal
  end
end
