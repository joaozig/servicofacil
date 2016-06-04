require 'rails_helper'

RSpec.describe Ad, type: :model do

	subject(:category) { Category.new(name: "Categoria") }
	subject(:subcategory) { Subcategory.new(name: "Subcategoria", category: category) }

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
end
