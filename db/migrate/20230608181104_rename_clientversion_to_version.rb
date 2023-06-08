class RenameClientversionToVersion < ActiveRecord::Migration[7.0]
  def change
  	rename_column :wificlients, :clientversion, :version
  end
end
