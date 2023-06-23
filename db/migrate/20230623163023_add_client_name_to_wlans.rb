class AddClientNameToWlans < ActiveRecord::Migration[7.0]
  def change
    add_column :wlans, :client_name, :string
  end
end
