include D2lApi

class OverviewController < ApplicationController
	def index
		@data = get_user current_user
	end
end
