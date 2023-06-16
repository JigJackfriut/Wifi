class AddPhoneToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :phone, :string
  end
end
