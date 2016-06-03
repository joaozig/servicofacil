require 'rails_helper'

RSpec.describe Category, type: :model do

	describe 'Validations' do
		it 'has a valid name' do
			category = Category.new(name: "João")
			expect(category).to be_valid
		end

		it 'with invalid name' do
			category = Category.new(name: nil)
			expect(category).to_not be_valid
		end
	end
end
