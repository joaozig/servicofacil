require 'rails_helper'

RSpec.describe Ad, type: :model do

	subject(:category) { Category.new(name: "Categoria") }
	subject(:subcategory) { Subcategory.new(name: "Subcategoria", category: category) }
	subject(:subcategory2) { Subcategory.new(name: "Subcategoria", category: category) }

	describe 'Validations' do
		it 'has a valid title and subcategory' do
			ad = Ad.new(title: "Anuncio", subcategory: subcategory)
			expect(ad).to be_valid
		end

		it 'with invalid title' do
			ad = Ad.new(subcategory: subcategory)
			expect(ad).to_not be_valid
		end

		it 'with invalid subcategory' do
			ad = Ad.new(title: "Anuncio")
			expect(ad).to_not be_valid
		end
	end

	describe 'Listing ads' do
		it 'approved ads with premiums first' do
			Ad.new(title: "Anuncio 1", status: :approved, premium:false , subcategory: subcategory).save!
			Ad.new(title: "Anuncio 2", status: :pending, subcategory: subcategory).save!
			Ad.new(title: "Anuncio 3", status: :rejected, premium:true, subcategory: subcategory).save!
			Ad.new(title: "Anuncio 4", status: :approved, premium: true, subcategory: subcategory).save!
			Ad.new(title: "Anuncio 0", status: :approved, subcategory: subcategory).save! # creating without premium
			Ad.new(title: "Anuncio 6", premium: true, subcategory: subcategory).save! # creating without status

			ads = Ad.approved
			expect(ads.count).to eq(3)
			expect(ads[0].title).to eq("Anuncio 4")
			expect(ads[1].title).to eq("Anuncio 0")
			expect(ads[2].title).to eq("Anuncio 1")
		end
	end
end
