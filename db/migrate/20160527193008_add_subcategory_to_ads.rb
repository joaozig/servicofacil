class AddSubcategoryToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :subcategory, index: true, foreign_key: true
  end
end
