require 'ruby-dictionary/dictionary'

class WordChain
    def initialize(dictionary)
        @dictionary = dictionary
    end

    def find_chain word_start, word_end
        current_word = word_start
        (current_word.slice(1, 1)..'z').each do |chr|
            current_word = "#{current_word.slice(0, 1)}#{chr}#{current_word.slice(2)}"
            puts current_word
            break if current_word == 'cot'
        end
    end
end

my_chain = WordChain.new [] #Dictionary.from_file('words.txt')
my_chain.find_chain('cat', 'dog')