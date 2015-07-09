class HomeController < ApplicationController
	
	def index
		Appliance.order("name")
		if Appliance.count > 0
			@appliances = Appliance.order("name").page(params[:page]).per(20)
			@searched_appliances = Appliance.reachable_targets(@appliances)
		end
	end

end
