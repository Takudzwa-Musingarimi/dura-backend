class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :english_name
      t.text :description
      t.decimal :price
      t.string :measurement_unit
      t.integer :total_units

      t.timestamps
    end
  end
end
