class AddAdvertiserToAds < ActiveRecord::Migration
  def change
    add_reference :ads, :advertiser, index: true, foreign_key: true
  end
end
