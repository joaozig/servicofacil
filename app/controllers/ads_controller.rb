class AdsController < ApplicationController

	def index
		@ads = Ad.where(status: Ad.statuses[:approved]).order(premium: :desc, title: :asc)
		# @ads = Ad::approved
	end
end
