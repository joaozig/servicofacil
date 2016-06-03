require 'rails_helper'

feature 'Advertiser signs up' do
	scenario 'with valid credentials' do
	  visit cadastro_path
	  fill_in 'advertiser_name', with: 'João Ricardo'
	  fill_in 'advertiser_email', with: 'joaoricardobastos@gmail.com'
	  fill_in 'advertiser_password', with: 'joaozig'
	  fill_in 'advertiser_password_confirmation', with: 'joaozig'
	  click_on 'Sign up'

	  expect(page).to have_content('Welcome! You have signed up successfully')
	end

	scenario 'invalid with no name' do
	  visit cadastro_path

	  fill_in 'advertiser_email', with: 'joaoricardobastos@gmail.com'
	  fill_in 'advertiser_password', with: 'joaozig'
	  fill_in 'advertiser_password_confirmation', with: 'joaozig'
	  click_on 'Sign up'

	  expect(page).to have_content("Name can't be blank")
	end
end
