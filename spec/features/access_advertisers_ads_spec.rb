require 'rails_helper'

feature 'Advertisers Ads restricted area' do

	subject(:advertiser1) { advertiser1 = Advertiser.create(name: "João", email: "joaoricardobastos@gmail.com", password: "joaozig") }
	subject(:advertiser2) { advertiser2 = Advertiser.create(name: "Aroldo", email: "joaoricardobastos@hotmail.com", password: "joaozig") }
	subject(:category) { category = Category.new(name: "Categoria") }
	subject(:subcategory) { subcategory = Subcategory.new(name: "Subcategoria", category: category) }

	scenario 'forbidden if not logged' do
	  visit advertisers_ads_path
	  expect(page).to have_content('You need to sign in or sign up before continuing')
	end

	scenario 'ok if logged' do
		login_as(advertiser1)
	  visit advertisers_ads_path
	  expect(page).to have_content('Ads')
	end

	scenario 'edit own ad' do
		login_as(advertiser1)

		ad = Ad.new(title: "teste", advertiser: advertiser1, subcategory: subcategory)
		ad.save!
	  visit edit_advertisers_ad_path(ad)
	  fill_in 'ad_title', with: 'Anuncio editado'
	  click_on 'Update Ad'
	  expect(page).to have_content('Ad was successfully updated')
	end

	scenario 'fails when edit own ad with blank title' do
		login_as(advertiser1)

		ad = Ad.new(title: "teste", advertiser: advertiser1, subcategory: subcategory)
		ad.save!
	  visit edit_advertisers_ad_path(ad)
	  fill_in 'ad_title', with: ''
	  click_on 'Update Ad'
	  expect(page).to have_content("Title can't be blank")
	end

	scenario 'show own ad' do
		login_as(advertiser1)

		ad = Ad.new(title: "teste", advertiser: advertiser1, subcategory: subcategory)
		ad.save!
	  visit advertisers_ad_path(ad)
	  expect(page).to have_content('teste')
	end

	scenario 'delete own ad' do
		login_as(advertiser1)

		ad = Ad.new(title: "teste", advertiser: advertiser1, subcategory: subcategory)
		ad.save!

	  visit advertisers_ads_path
	  click_on 'Delete'

	  expect(page).to have_content('Ad was successfully destroyed')
	end

	scenario 'fails when try to access ad edit page from other advertiser' do
		login_as(advertiser1)

		advertiser2.save!
		ad = Ad.new(title: "teste2", advertiser: advertiser2, subcategory: subcategory)
		ad.save!
	  visit edit_advertisers_ad_path(ad)
	  expect(page).to_not have_content('Edit Ad')
	end

	scenario 'fails when show ad from other advertiser' do
		login_as(advertiser1)

		advertiser2.save!
		ad = Ad.new(title: "teste2", advertiser: advertiser2, subcategory: subcategory)
		ad.save!
	  visit advertisers_ad_path(ad)
	  expect(page).to_not have_content('teste2')
	end
end

