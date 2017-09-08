class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :caption
      t.boolean :release_status

      t.timestamps
    end
  end
end
