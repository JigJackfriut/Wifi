class ChangeOpenApToBeBooleanInZones < ActiveRecord::Migration[7.0]
  def change
  	change_column :zones, :open_ap, :boolean
  end
end
