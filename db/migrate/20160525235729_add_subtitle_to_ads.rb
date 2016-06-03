class AddSubtitleToAds < ActiveRecord::Migration
  def change
    add_column :ads, :subtitle, :string
  end
end
