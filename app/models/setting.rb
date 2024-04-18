class Setting < ApplicationRecord

	def self.email_setting(user)
	    day = Date.today + 2
	    @orders_date = user.orders.select { |order| order.delivery_date == day }
	    
	    # debugger
	end
end
