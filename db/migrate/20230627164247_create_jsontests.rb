class CreateJsontests < ActiveRecord::Migration[7.0]
  def change
    create_table :jsontests do |t|
      t.text :config_json

      t.timestamps
    end
  end
end
