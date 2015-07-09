class Appliance < ActiveRecord::Base
	has_many :targets, dependent: :destroy

	validates :name,     uniqueness: true,
	                   presence:   true

	validates :customer, presence:   true


  	
  def self.reachable_targets(appliances)
		threads = []
		hash  = {}
		appliances.each do |appliance|
			reachable_array = []
			non_reachable_array = []
			appliance.targets.each do |target|
				threads << Thread.new do
					if self.ping_status(target.address)
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

	def self.ping_status(ip)
		`ping -c 1 #{ip} >> output.log &`
		ping_data =`tail -n4 output.log`
		ping_status = ping_data.split(",").map(&:strip).include?("1 received")
	end
end
