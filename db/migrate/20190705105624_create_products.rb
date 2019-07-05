class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string  :name
      t.decimal :price, precision: 15, scale: 2
      t.string  :image

      t.timestamps
    end
  end
end
