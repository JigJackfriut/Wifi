class ChangeChannelGToBeTextInWlans < ActiveRecord::Migration[7.0]
  def change
  	change_column :wlans, :g, :text
  end
end
