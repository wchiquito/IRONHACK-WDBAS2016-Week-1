class TableOfPrices
	attr_reader :currency, :cost 
	
	def initialize
		@cost = {
			"apple": 10,
			"orange": 5,
			"grapes": 15,
			"banana": 20,
			"watermelon": 50
		}
		@currency = '$'
	end
end

class ShoppingCart
	def initialize tableOfPrices
		@tableOfPrices = tableOfPrices
		@fruits = {}
	end

	def add_item_to_cart fruit
		_fruit = @fruits[fruit]		
		if _fruit
			@fruits[fruit] += 1
		else
			@fruits[fruit] = 1
		end
	end

	def price_by_fruit fruit
		@fruits[fruit] * @tableOfPrices.cost[fruit].to_f
	end

	def make_price price
		"#{@tableOfPrices.currency}#{price}"
	end

	def cost
		total_price = 0
		@fruits.each_key do |key|
			total_price += price_by_fruit key
		end
		print_message "Total: #{make_price total_price}"
	end

	def show
		@fruits.each do |key, value|
			print_message "#{value} #{key}: #{make_price price_by_fruit key}"
		end
	end

	def print_message message
		puts message
	end
end

cart = ShoppingCart.new TableOfPrices.new
cart.add_item_to_cart :apple
cart.add_item_to_cart :banana
cart.add_item_to_cart :banana
cart.show
cart.cost