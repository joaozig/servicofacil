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

	scenario 'ok show own ad' do
		login_as(advertiser1)

		ad = Ad.new(title: "teste", advertiser: advertiser1, subcategory: subcategory)
		ad.save!
	  visit advertisers_ad_path(ad)
	  expect(page).to have_content('teste')
	end

	scenario 'fail show ad from other advertiser' do
		login_as(advertiser1)

		advertiser2.save!
		ad = Ad.new(title: "teste2", advertiser: advertiser2, subcategory: subcategory)
		ad.save!
	  visit advertisers_ad_path(ad)
	  expect(page).to_not have_content('teste2')
	end
end

