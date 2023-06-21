class RenameOpenToOpenAp < ActiveRecord::Migration[7.0]
  def change
  	rename_column :zones, :open, :open_ap
  end
end
