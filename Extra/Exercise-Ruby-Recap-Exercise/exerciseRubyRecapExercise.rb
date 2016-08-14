# 1. Power
def power number_one, number_two
	number_one ** number_two
end
puts power 3, 4

# 2. Reverse
def reverse text
	text.reverse!
end
puts reverse 'You are not going anywhere'

# 3. Factorial
def factorial number
	return 'Invalid number' if number < 0
	return number * (factorial number - 1) if number > 1
	1
end
puts factorial 5

# 4. Time Conversion
def time_conversion time_in_minutes
	return 'Invalid time' if time_in_minutes < 0
	(Time.at(time_in_minutes * 60)).strftime('%k:%M').strip
end
puts time_conversion 500

# 5. Count Vowels
def count_vowels text
	text.downcase.scan(/[aeouiáéíóú]/).count
end
puts count_vowels 'hello'

# 6. Uniques
def uniques array_of_items
	uniq = []
	array_of_items.each_with_index do |item, index|
		if uniq.include? item
			array_of_items.delete_at(index)
		else
			uniq.push item
		end
	end
	array_of_items.to_s
end
puts uniques [1, 5, 'frog', 2, 1, 3, 'frog']

# 7. Is prime
def is_prime? number
	return 'Invalid number' if number < 2
	(2..Math.sqrt(number)).none? { |current| number % current == 0 }
end
puts is_prime?(7)
puts is_prime?(14)

# 8. Palindrome
def palindrome? text
	text == text.reverse
end
puts palindrome? 'radar'
puts palindrome? 'bear'

# 9. Capitalize Words
def capitalize_words text
	delimiter = 32.chr
	(text.split delimiter).map!(&:capitalize).join delimiter
end
puts capitalize_words 'how is the capital today?'

# 10. Two Sum
def two_sum array_of_numbers
	array_of_numbers_length = array_of_numbers.length - 1
	nil unless array_of_numbers.each_index do |index_outer|
		array_of_numbers.each_index do |index_inner|
			index_inner_plus = index_outer + index_inner + 1
			break if (index_inner_plus) > array_of_numbers_length
			if array_of_numbers[index_outer] + array_of_numbers[index_inner_plus] == 0
				return [index_outer, index_inner_plus]
			end
		end
	end
end
puts (two_sum [2, -5, 10, 5, 4, -10, 0]).to_s

def greatest_common_factor number_one, number_two
	[number_one, number_two].reduce(&:gcd)
end
puts greatest_common_factor 12, 16

# 12. Print Polynomials
def polynomial array_of_numbers
	array_of_numbers_length = array_of_numbers.length - 1
	return 'Invalid' if array_of_numbers_length < 1
	polynomial = []; expression = ''
	sign = lambda do |number, index, expression_length, is_last_position|
		return '' if number < 1 ||
					 index == 0 ||
		             expression_length == 0 ||
		             number == 1 && is_last_position 
		'+'
	end
	coefficient = lambda do |number, is_last_position|
		return '' if number == 1
		return '-' if number == -1 && !is_last_position
		number.to_s
	end
	exponent = lambda do |reverse_index|
		return "x^#{reverse_index}" if reverse_index > 1
		return 'x' if reverse_index == 1
		''
	end
	array_of_numbers.each_with_index do |number, index|
		next if number == 0
		is_last_position = array_of_numbers_length == index
		expression = sign.call number, index, expression.length, is_last_position
		expression += coefficient.call number, is_last_position
		expression += exponent.call array_of_numbers_length - index
		polynomial << expression
	end
	polynomial.join
end
puts polynomial [-3, -4, 1, 0, 6]