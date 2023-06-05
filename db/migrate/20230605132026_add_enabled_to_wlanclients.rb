class AddEnabledToWlanclients < ActiveRecord::Migration[7.0]
  def change
    add_column :wlanclients, :enabled, :boolean
  end
end
