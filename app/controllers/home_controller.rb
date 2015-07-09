class HomeController < ApplicationController
	
	def index
		@appliances = Appliance.order("name").page(params[:page]).per(20)
		@searched_appliances = Appliance.reachable_targets(@appliances)
	end

end
