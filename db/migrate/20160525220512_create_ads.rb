class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :title
      t.text :description
      t.integer :status
      t.boolean :premium

      t.timestamps null: false
    end
  end
end
