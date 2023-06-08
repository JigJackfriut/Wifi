class RenameOsversionToOs < ActiveRecord::Migration[7.0]
  def change
  	rename_column :wificlients, :osversion, :os
  end
end
