class AddEnabledToWlans < ActiveRecord::Migration[7.0]
  def change
    add_column :wlans, :enabled, :boolean
  end
end
