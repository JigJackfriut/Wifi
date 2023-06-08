class RenameHwmodelToModel < ActiveRecord::Migration[7.0]
  def change
  	rename_column :wificlients, :hwmodel, :model
  end
end
