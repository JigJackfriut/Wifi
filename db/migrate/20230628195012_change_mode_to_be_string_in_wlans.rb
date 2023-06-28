class ChangeModeToBeStringInWlans < ActiveRecord::Migration[7.0]
  def change
	change_column :wlans, :mode, :string
  end
end
