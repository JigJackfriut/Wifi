class AddSelectedAToWlans < ActiveRecord::Migration[7.0]
  def change
    add_column :wlans, :selected_a, :string
  end
end
