class CreateStationLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :station_logs do |t|
      t.string :AP
      t.string :station
      t.string :interface
      t.integer :channel
      t.integer :rx_bytes
      t.integer :tx_bytes
      t.integer :tx_retries
      t.integer :tx_failed
      t.string :signal
      t.string :signal_avg
      t.string :tx_bitrate
      t.string :rx_bitrate
      t.string :expected_throughput
      t.string :associated
      t.integer :vid
      t.string :ssid
      t.integer :user_id
      t.string :event
      t.string :mac

      t.timestamps
    end
  end
end
