# Pair: Unai Camino

class Room
	attr_reader :description, :exits

	def initialize description, exits
		@description = description
		@exits = exits
	end
end

class Game
	def initialize rooms 
		@rooms = rooms
		@position = 0
		@last_room = rooms.length - 1
	end

	def question
		puts "N, S, E, W?"
		answer = gets.chomp.upcase
		if @rooms[@position].exits[answer.to_sym]
			if @position == @last_room
				puts "Win"
				return
			end
			@position += 1
		end
		show_room
	end

	def show_room
		puts @rooms[@position].description
		question
	end
end

game = Game.new [
		Room.new("ONE", { N: true, S: false, E: false, W: false }),
		Room.new("TWO", { N: false, S: false, E: false, W: true }),
		Room.new("THREE", { N: false, S: true, E: false, W: false }),
		Room.new("FOUR", { N: false, S: false, E: true, W: false }),
		Room.new("FIVE", { N: true, S: false, E: false, W: false })
	]
game.show_room