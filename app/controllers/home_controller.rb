require 'socket'
require 'timeout'

class HomeController < ApplicationController
	def index
		@appliances = Appliance.order("name").page(params[:page]).per(20)
		@searched_appliances = reachable_targets(@appliances)
	end

	private
		def reachable_targets(appliances)
			threads = []
			hash  = {}
			appliances.each do |appliance|
				reachable_array = []
				non_reachable_array = []
				appliance.targets.all.each do |target|
					threads << Thread.new do
						`ping -c 1 #{target.address} >> output.log &`
						ping_data =`tail -n4 output.log`
						ping_status = ping_data.split(",").map(&:strip).include?("1 received")
						if ping_status
							reachable_array << target.address 
						else
							non_reachable_array << target.address
						end
					end
				end
				hash.merge!(appliance.name => {reachable: reachable_array, non_reachable:  non_reachable_array})
			end
			threads.map(&:join)
			hash
		end
end
