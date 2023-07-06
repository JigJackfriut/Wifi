class RenameUpdateNeededToConfigChange < ActiveRecord::Migration[7.0]
  def change
	rename_column :wificlients, :update_needed, :config_change
  end
end
