class AddManagerIdAndRxPacketsAndTxPacketsToStationLog < ActiveRecord::Migration[7.0]
  def change
    add_column :station_logs, :manager_id, :integer
    add_index :station_logs, :manager_id
    add_column :station_logs, :rx_packets, :integer
    add_column :station_logs, :tx_packets, :integer
  end
end
