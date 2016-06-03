require 'rails_helper'

RSpec.describe Subcategory, type: :model do

	subject(:category) { Category.new(name: "Categoria") }

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
end
