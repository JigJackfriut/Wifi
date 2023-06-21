class CreateUserzones < ActiveRecord::Migration[7.0]
  def change
    create_table :userzones do |t|
      t.integer :zone_id
      t.integer :user_id
      t.string :pmk

      t.timestamps
    end
    add_index :userzones, :zone_id
    add_index :userzones, :user_id
  end
end
