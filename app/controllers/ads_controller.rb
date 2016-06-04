class AdsController < ApplicationController

	def index
		@ads = Ad.approved
	end
end
