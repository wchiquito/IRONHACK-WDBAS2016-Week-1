hash = {"wat": [{}, {}, {"wut": [0, [[0, 1, 2, 3, 4, 5, 6, 7, 8, {"bbq": 'bbq'}]]]}]}

puts hash[:wat][2][:wut][1][0][9][:bbq]

arr = [[0, 1, 2, 3, 4, {"secret": {"unlock": [0, 'unlock']}}]]

puts arr[0][5][:secret][:unlock][1]

class CarDealer
	def initialize
		@cars = {}
	end

	def add_car car
		if @cars[car.brand]
			@cars[car.brand].push car.model
		else
			@cars[car.brand] = [car.model]
		end
	end
	
	def cars brand
		if @cars[brand]
			"#{brand}: #{@cars[brand].join(', ')}"
		end
	end
end

class Car
	attr_reader :brand, :model
	
	def initialize brand, model
		@brand = brand
		@model = model
	end
end

car_dealer = CarDealer.new
car_dealer.add_car Car.new 'Ford', 'Fiesta'
car_dealer.add_car Car.new 'Ford', 'Mustang'
car_dealer.add_car Car.new 'Honda', 'Civic'
puts car_dealer.cars 'Ford'
puts car_dealer.cars 'Honda'

class Engine
	def make_noise
		"#{self.class}.NOISE"
	end
end

class Car2
	def initialize engine
		@engine = engine
	end

	def make_noise
		puts "#{self.class}.NOISE"
		puts "#{@engine.class}.NOISE"
	end
end

Car2.new(Engine.new).make_noise
