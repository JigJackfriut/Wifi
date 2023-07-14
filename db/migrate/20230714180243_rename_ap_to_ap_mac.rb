class RenameApToApMac < ActiveRecord::Migration[7.0]
  def change
  	rename_column :station_logs, :ap, :ap_mac
  end
end
