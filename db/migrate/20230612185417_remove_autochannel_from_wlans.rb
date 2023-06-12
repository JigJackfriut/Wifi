class RemoveAutochannelFromWlans < ActiveRecord::Migration[7.0]
  def change
  	remove_column :wlans, :autochannel
  end
end
