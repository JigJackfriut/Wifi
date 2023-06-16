class AddStateToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :state, :string
  end
end
