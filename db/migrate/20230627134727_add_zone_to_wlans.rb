class AddZoneToWlans < ActiveRecord::Migration[7.0]
  def change
    add_column :wlans, :zone, :string
  end
end
