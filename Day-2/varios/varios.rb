class Car
	def initialize sound = 'Mec-Mec', name
		#@cities = []
		@name = name
		@sound = sound
		create_file_city
	end

	def make_noise
		puts @sound
	end

	def write_in_file content
		IO.write "cities#{@name}.txt", content	
	end

	def create_file_city
		write_in_file ''
	end

	def read_file_city
		IO.read "cities#{@name}.txt"
	end

	def write_file_city city
		content = read_file_city
		write_in_file content << city << "\n"
	end
	
	def add_city city
		#@cities.push city
		write_file_city city
	end

	def cities
		puts read_file_city
	end
	
	def self.speed_control
		puts 'Current speed: '
		speed = gets.chomp.to_i
		if speed > 100
			puts 'Speed above 100'
		end
	end
	
	def self.count
		puts @sound
		puts @sound.nil?
	end
end

class RacingCar < Car
	def initialize sound = 'BROOOM', name
		@name = name		
		@sound = sound
	end
end

# myCar = Car.new 'Broom'
# myCar.make_noise

# yourCar = Car.new 'BROOOOOOM'
# yourCar.make_noise

# your1Car = Car.new
# your1Car.make_noise

# Car.speed_control
# Car.count

car_one = Car.new 'Mec-Mec', 'Car1'
car_one.make_noise
car_one.add_city 'Madrid'
car_one.add_city 'Barcelona'
car_one.add_city 'Miami'
car_one.cities

rc = RacingCar.new @name = 'RC1'
rc.make_noise

class Person
	attr_reader :name
	
	def initialize 	name, age
		@name = name
		@age = age
	end
end

p1 = Person.new 'JJJ', 1
puts p1.name