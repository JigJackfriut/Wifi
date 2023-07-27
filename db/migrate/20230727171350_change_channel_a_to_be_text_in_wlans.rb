class ChangeChannelAToBeTextInWlans < ActiveRecord::Migration[7.0]
  def change
  	change_column :wlans, :a, :text
  end
end
