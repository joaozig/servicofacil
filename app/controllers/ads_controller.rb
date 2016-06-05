class AdsController < ApplicationController

	def index
		@ads = Ad.approved.paginate(page: params[:page])
	end
end
