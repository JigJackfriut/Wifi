class ChangeSizeOfRxTxInt < ActiveRecord::Migration[7.0]
  def change
    change_column :station_logs, :rx_bytes, :bigint
    change_column :station_logs, :tx_bytes, :bigint
  end
end
