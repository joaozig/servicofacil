require 'rails_helper'

RSpec.describe Subcategory, type: :model do

	subject(:category) { Category.new(name: "Categoria") }
	subject(:subcategory) { Subcategory.new(name: "Subcategoria", category: category) }
	subject(:subcategory2) { Subcategory.new(name: "Subcategoria", category: category) }

	describe 'Validations' do
		it 'has a valid name and category' do
			subcategory = Subcategory.new(name: "Subcategoria", category: category)
			expect(subcategory).to be_valid
		end

		it 'with invalid name' do
			subcategory = Subcategory.new(name: nil, category: category)
			expect(subcategory).to_not be_valid
		end

		it 'with invalid category' do
			subcategory = Subcategory.new(name: "Subcategoria")
			expect(subcategory).to_not be_valid
		end
	end

	describe 'Listing ads from subcategory' do
		it 'approved ads with premiums first' do
			Ad.new(title: "Anuncio 1", status: Ad.statuses[:approved], premium:false , subcategory: subcategory2).save!
			Ad.new(title: "Anuncio 2", status: Ad.statuses[:pending], subcategory: subcategory).save!
			Ad.new(title: "Anuncio 3", status: Ad.statuses[:rejected], premium:true, subcategory: subcategory2).save!
			Ad.new(title: "Pendente", status: Ad.statuses[:pending], premium:true, subcategory: subcategory2).save!
			Ad.new(title: "Anuncio 4", status: Ad.statuses[:approved], premium: true, subcategory: subcategory2).save!
			Ad.new(title: "Anuncio 0", status: Ad.statuses[:approved], subcategory: subcategory).save! # creating without premium
			Ad.new(title: "Anuncio 6", premium: true, subcategory: subcategory).save! # creating without status

			ads = subcategory2.ads.approved
			expect(ads.count).to eq(2)
			expect(ads[0].title).to eq("Anuncio 4")
			expect(ads[1].title).to eq("Anuncio 1")
		end
	end
end
