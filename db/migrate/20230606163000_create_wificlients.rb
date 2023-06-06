class CreateWificlients < ActiveRecord::Migration[7.0]
  def change
    create_table :wificlients do |t|
      t.string :location
      t.string :ipaddress
      t.string :clientversion
      t.string :osversion
      t.string :hwmodel
      t.string :status
      t.decimal :pollrate
      t.datetime :lastseen
      t.string :note
      t.string :name
      t.datetime :dateadded
      t.string :confighash
      t.decimal :ownerid
      t.boolean :enabled

      t.timestamps
    end
  end
end
