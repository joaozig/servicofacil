class AddNameToAdvertisers < ActiveRecord::Migration
  def change
    add_column :advertisers, :name, :string
  end
end
