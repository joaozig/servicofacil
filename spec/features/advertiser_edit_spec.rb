require 'rails_helper'

feature 'Edit Advertiser' do

	subject(:advertiser1) { advertiser1 = Advertiser.create(name: "João", email: "joaoricardobastos@gmail.com", password: "joaozig") }
	subject(:advertiser2) { advertiser2 = Advertiser.create(name: "Aroldo", email: "joaoricardobastos@hotmail.com", password: "joaozig") }

	scenario 'forbidden if not logged' do
	  visit edit_advertiser_registration_path
	  expect(page).to have_content('You need to sign in or sign up before continuing')
	end

	scenario 'ok if logged' do
		login_as(advertiser1)
	  visit edit_advertiser_registration_path
	  expect(page).to have_content('Edit Advertiser')
	end

	scenario 'with valid inputs' do
		login_as(advertiser1)
	  visit edit_advertiser_registration_path
	  fill_in 'advertiser_name', with: 'João Ricardo'
	  fill_in 'advertiser_email', with: 'joaoricardobastos@gmail.com.br'
	  fill_in 'advertiser_current_password', with: 'joaozig'
	  click_on 'Update'

	  expect(page).to have_content('Your account has been updated successfully')
	  check_changes
	end

	scenario 'fails when leaves current password blank' do
		login_as(advertiser1)
	  visit edit_advertiser_registration_path
	  fill_in 'advertiser_name', with: 'João Ricardo!'
	  fill_in 'advertiser_email', with: 'joaoricardobastos@gmail.com.br'
	  click_on 'Update'

	  expect(page).to have_content("Current password can't be blank")
	  advertiser1 = Advertiser.first
		check_no_changes
	end

	scenario 'fails when fills with wrong current password' do
		login_as(advertiser1)
	  visit edit_advertiser_registration_path
	  fill_in 'advertiser_name', with: 'João Ricardo!'
	  fill_in 'advertiser_email', with: 'joaoricardobastos@gmail.com.br'
	  fill_in 'advertiser_current_password', with: 'jota'
	  click_on 'Update'

	  expect(page).to have_content("Current password is invalid")
	  advertiser1 = Advertiser.first
		check_no_changes
	end

	scenario 'fails when fills with existent email' do
		login_as(advertiser1)
		advertiser2.save!
	  visit edit_advertiser_registration_path
	  fill_in 'advertiser_name', with: 'João Ricardo!'
	  fill_in 'advertiser_email', with: 'joaoRiCaRDobastos@HOTmail.com'
	  fill_in 'advertiser_current_password', with: 'joaozig'
	  click_on 'Update'

	  expect(page).to have_content("Email has already been taken")
	  check_no_changes
	end

	def check_no_changes
	  advertiser1 = Advertiser.first
	  expect(advertiser1.name).to eq('João')
	  expect(advertiser1.email).to eq('joaoricardobastos@gmail.com')
	end

	def check_changes
	  advertiser1 = Advertiser.first
	  expect(advertiser1.name).to eq('João Ricardo')
	  expect(advertiser1.email).to eq('joaoricardobastos@gmail.com.br')
	end
end
