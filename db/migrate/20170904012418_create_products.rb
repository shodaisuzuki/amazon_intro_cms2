class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :site, foreign_key: true
      t.string :title
      t.text :introduction
      t.integer :price
      t.string :image_id
      t.boolean :release_status
      t.string :amazon_id

      t.timestamps
    end
    add_index :products, :image_id, unique: true
  end
end
