class Home
    attr_reader(:name, :city, :capacity, :price)

    def initialize(name, city, capacity, price)
        @name = name
        @city = city
        @capacity = capacity
        @price = price
    end
end

# homes = [
#     Home.new('Nizar\'s place', 'San Juan', 2, 42),
#     Home.new('Fernando\'s place', 'Seville', 5, 47),
#     Home.new('Josh\'s place', 'Pittsburgh', 3, 41),
#     Home.new('Gonzalo\'s place', 'Málaga', 2, 45),
#     Home.new('Ariel\'s place', 'San Juan', 4, 49)
# ]

# homes.each do |hm|
#   puts "#{hm.name} in #{hm.city}\nPrice: $#{hm.price} a night"
# end

# total_price = 0.0
# homes_price = homes.map do |home|
#     total_price += home.price
#     home.price
# end

# puts homes_price
# puts total_price / homes.length

# total_capacities = 0.0
# homes.each do |hm|
#   total_capacities = total_capacities + hm.capacity
# end

# puts "The average capacity is:"
# puts total_capacities / homes.length

# total_capacities = homes.reduce(0.0) do |sum, hm|
#   sum + hm.capacity
# end

# puts "The average capacity is:"
# puts total_capacities / homes.length

# total_prices = homes.reduce(0.0) do |sum, hm|
#   sum + hm.price
# end

# puts "The average price is:"
# puts total_price / homes.length

homes = [
    Home.new('Nizar\'s place', 'San Juan', 2, 42),
    Home.new('Fernando\'s place', 'Seville', 5, 47),
    Home.new('Josh\'s place', 'Pittsburgh', 3, 41),
    Home.new('Gonzalo\'s place', 'Málaga', 2, 45),
    Home.new('Ariel\'s place', 'San Juan', 4, 49)
]
NOT_HOMES = 'Not homes'

def print_message message
    puts message
end

def print_home home
    print_message "#{home.name} in #{home.city}\nPrice: $#{home.price} a night\nCapacity: #{home.capacity}"
end

def list_of_homes homes
    if homes.length > 0
        homes.each do |hm|
            print_home hm
        end    
    else    
        print_message NOT_HOMES
    end
end

def order_by_prices_asc homes
    if homes.length > 0
        homes_order_by_price = homes.sort { |pre, cur| pre.price <=> cur.price }
        list_of_homes homes_order_by_price
    else
        print_message NOT_HOMES
    end

end

def order_by_prices_desc homes
    if homes.length > 0
        homes_order_by_price = homes.sort { |pre, cur| cur.price <=> pre.price }
        list_of_homes homes_order_by_price
    else
        print_message NOT_HOMES
    end
end

def order_by_capacity homes
    if homes.length > 0
        homes_order_by_capacity = homes.sort { |pre, cur| pre.capacity <=> cur.capacity }
        list_of_homes homes_order_by_capacity
    else
        print_message NOT_HOMES
    end
end

def filter_by_city homes, city
    if homes.length > 0
        list_by_city = homes.select do |hm|
            hm.city.downcase == city.downcase
        end
        if list_by_city.length
            list_of_homes list_by_city
        else
            print_message NOT_HOMES
        end
    else
        print_message NOT_HOMES 
    end
end

def average homes
    if homes.length > 0
        total_prices = homes.reduce(0.0) do |sum, hm|
            sum + hm.price
        end
        list_of_homes homes
        print_message "The average price is: #{total_prices / homes.length}"
    else
        print_message NOT_HOMES
    end
end

def filter_by_price homes, price
    if homes.length > 0
        first_home = homes.find do |hm|
            hm.price == price
        end
        if first_home
            print_home first_home
        else
            print_message NOT_HOMES            
        end
    else
        print_message NOT_HOMES
    end
end

continue = -1
while (continue != 0)
    puts 'Options:'
    puts '1) List of homes'
    puts '2) Order by Price (ASC)'
    puts '3) Order by Price (DESC)'
    puts '4) Order by Capacity (ASC)'
    puts '5) Filter by City'
    puts '6) Average'
    puts '7) Filter by Price'
    puts '0) Exit'
    continue = gets.chomp.to_i
    case continue
        when 0
            break
        when 1
            list_of_homes homes
        when 2
            order_by_prices_asc homes
        when 3
            order_by_prices_desc homes
        when 4
            order_by_capacity homes
        when 5
            print_message 'Please, input City:'
            city = gets.chomp
            filter_by_city homes, city
        when 6
            average homes
        when 7
            print_message 'Please, input Price:'
            price = gets.chomp.to_i
            filter_by_price homes, price
        else
            print_message 'Please, select a valid option'
    end
end
