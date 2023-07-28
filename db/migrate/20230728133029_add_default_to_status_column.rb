class AddDefaultToStatusColumn < ActiveRecord::Migration[7.0]
  def change
	change_column_default :wificlients, :status, from:nil, to:"Turned Off"
  end
end
