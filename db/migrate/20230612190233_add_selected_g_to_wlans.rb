class AddSelectedGToWlans < ActiveRecord::Migration[7.0]
  def change
    add_column :wlans, :selected_g, :string
  end
end
