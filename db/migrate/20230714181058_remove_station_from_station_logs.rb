class RemoveStationFromStationLogs < ActiveRecord::Migration[7.0]
  def change
  remove_column :station_logs, :station, :string
  end
end
