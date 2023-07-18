class AddConnectedTimeToStationLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :station_logs, :connected_time, :string
  end
end
