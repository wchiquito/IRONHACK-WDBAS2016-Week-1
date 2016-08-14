module Command_Line
	def question text
		print "#{text}: "
		gets.chomp
	end
	
	def print_result message, value
		print_message "#{'*' * 50}"
		print_message ''
		print_message "#{message}: #{value}"
		print_message ''
		print_message "#{'*' * 50}"
	end

	def print_message message
		puts "#{message}"
	end
end

class Login
	include Command_Line
	
	def initialize
		@username = 'user'
		@password = '123'
	end

	def credentials
		username = question 'username'
		password = question 'password'
		return username, password
	end
	
	def authenticate username, password
		username == @username && password == @password
	end

	def main
		username, password = credentials
		if authenticate username, password
			{"status": true}
		else
			{"status": false, "message": 'Invalid credencials'}
		end
	end
end

class Option
	attr_reader :option, :options_to_menu

	def initialize
		@option = {
			"0": {'method': 'exit'.to_sym, 'text': 'Exit'},
			"1": {'method': 'len_words'.to_sym, 'text': 'Count words', 'message': '# Words'},
			"2": {'method': 'len_letters'.to_sym, 'text': 'Count letters', 'message': '# Letters'},
			"3": {'method': 'reverse'.to_sym, 'text': 'txet esreveR (Reverse text)', 'message': 'Reverse text'},
			"4": {'method': 'upper'.to_sym, 'text': 'UPPERCASE TEXT', 'message': 'UPPERCASE'},
			"5": {'method': 'down'.to_sym, 'text': 'downcase text', 'message': 'downcase'}
		}
		@options_to_menu = show_options
	end

	def show_options
		options = []
		@option.each do |key, value|
			options.push "#{key}. #{value['text'.to_sym]}"
		end
		@options = options.join "\n"
	end
end

class Word
	def initialize word
		@word = word
	end

	def only_letters
		@word.gsub(/\s+/, "")
	end

	def is_valid?
		len_letters > 0
	end

	def len_letters
		only_letters.length
	end

	def len_words
		@word.split(' ').length
	end

	def reverse
		@word.reverse
	end

	def upper
		@word.upcase
	end

	def down
		@word.downcase
	end
end

class Menu
	include Command_Line
	
	def get_access
		login = Login.new
		login.main
	end

	def get_word
		word = question 'Please, Words'
		@word_instance = Word.new word
		@word_instance.is_valid?
	end

	def get_option
		option = question "\nPlease, enter a option"
		option.to_i
	end

	def execute_option options, option
		action = options.option[option.to_s.to_sym]
		if action
			method = action[:method]
			print_result action[:message], "#{@word_instance.send method}"
		end
	end

	def show_options options
		option = 1
		while (option > 0)
			print_message options.options_to_menu
			option = get_option
			execute_option options, option
		end
	end

	def main
		access = get_access
		if access['status'.to_sym]
			if get_word
				show_options Option.new
			else
				print_message 'Invalid word'
			end
		else
			print_message access['message'.to_sym]
		end
	end
end

program = Menu.new
program.main