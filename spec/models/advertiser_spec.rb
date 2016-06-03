require 'rails_helper'

RSpec.describe Advertiser, type: :model do

	subject(:advertiser) {
												Advertiser.new(name: "João",
																			 email: "joaoricardobastos@gmail.com",
																			 password: "joaozig")
											}

	describe 'Validations' do
		it 'with all required attributes' do
			expect(advertiser).to be_valid
		end

		it 'with invalid name' do
			advertiser.name = nil
			expect(advertiser).to_not be_valid
		end

		it 'with invalid email' do
			advertiser.email = nil
			expect(advertiser).to_not be_valid
		end

		it 'with invalid password' do
			advertiser.password = nil
			expect(advertiser).to_not be_valid
		end
	end
end
