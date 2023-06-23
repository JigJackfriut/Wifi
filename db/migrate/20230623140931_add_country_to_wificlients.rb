class AddCountryToWificlients < ActiveRecord::Migration[7.0]
  def change
    add_column :wificlients, :country, :string
  end
end
