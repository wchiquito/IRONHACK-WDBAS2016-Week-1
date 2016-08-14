class ProgrammingLanguage
    attr_accessor :name, :age, :type

    def initialize(name, age, type)
        @name = name
        @age = age
        @type = type
    end
end

ruby = ProgrammingLanguage.new("Ruby", 21, "Dynamic")
python = ProgrammingLanguage.new("Python", 24, "Dynamic")
javascript = ProgrammingLanguage.new("JavaScript", 20, "Dynamic")
go = ProgrammingLanguage.new("Go", 6, "Static")
rust = ProgrammingLanguage.new("Rust", 5, "Static")
swift = ProgrammingLanguage.new("Swift", 2, "Static")
java = ProgrammingLanguage.new("Java", 20, "Static")

array_of_languages = [ruby, python, javascript, go, rust, swift, java]

def array_printer(array, section)
    section = "*** #{section} ***" 
    puts section
    array.each do |language|
        puts "Language: #{language.name} | Age: #{language.age} | type: #{language.type}"
    end
    puts section
end

array_printer array_of_languages, 'Each'

array_of_languages_age_plus_one = array_of_languages.map do |language|
    language.age += 1
    language
end

array_printer array_of_languages_age_plus_one, 'Map'

array_of_languages_sort_age = array_of_languages.sort do |pre, cur|
    cur.age <=> pre.age
end

array_printer array_of_languages_sort_age, 'Sort age oldest to newest'

#array_of_languages_without_java = array_of_languages.map do |language|
#    language
#end

array_of_languages_without_java = array_of_languages.clone

array_of_languages_without_java.delete_if { |language| language.name.downcase == 'java' }

array_printer array_of_languages_without_java, 'Delete Java'

array_printer array_of_languages_sort_age.shuffle, 'Sort age oldest to newest with shuffle'

array_of_languages.map! do |language|
    language.name << '!!!'
    language
end

array_printer array_of_languages, 'Name with exclamations'