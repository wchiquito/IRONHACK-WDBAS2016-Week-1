require 'date'

module Helper
	SPLIT_PATTERN = ' --> '

	def join_time time
		time.join(SPLIT_PATTERN)
	end

	def divide_time time
		time.split(SPLIT_PATTERN)
	end
end

class SRT
	include Helper

	SPLIT_MAX = 3
	CENSORED = 'CENSORED'
	PATTERN_LINE = "\n"
	PATTERN_ENTRY = PATTERN_LINE * 2
	TIME_FORMAT = '%H:%M:%S,%L'

	def initialize filename, censored = true
		@filename = filename
		@censored = censored
		@entries = []
		@profanity_words = ['clusterfuck', 'douchebags']
	end

	def get_profanity_words
		Regexp.new(Regexp.union(@profanity_words).source, Regexp::IGNORECASE)
	end
	
	def apply_filter
		@file = @file.gsub get_profanity_words, CENSORED	
	end
	
	def load_file
		@file = IO.read @filename
		apply_filter if @censored
		@file.split(PATTERN_ENTRY).each do |entry|
			entry_parts = entry.split(PATTERN_LINE, SPLIT_MAX)
			@entries.push Entry.new entry_parts[0],
									entry_parts[1],
									entry_parts[2]
		end
	end

	def shift time_in_milliseconds
		@shift_time_in_milliseconds = time_in_milliseconds
	end

	def absolute_time_in_milliseconds time_in_milliseconds
		time_in_milliseconds.to_i.abs
	end
	
	def forwards time_in_milliseconds
		shift absolute_time_in_milliseconds time_in_milliseconds
	end

	def backwards time_in_milliseconds
		shift (absolute_time_in_milliseconds time_in_milliseconds) * -1
	end

	def change_time time
		(DateTime.parse(time) + (@shift_time_in_milliseconds / (86400.0 * 1000))).strftime(TIME_FORMAT)
	end
	
	def generate_shift_entries
		@entries.map do |entry|
			[entry.number,
			join_time([change_time(entry.time_start), 
			           change_time(entry.time_end)
			          ]),
			entry.subtitle].join(PATTERN_LINE)
		end
	end

	def generate_new_file filename
		IO.write filename, generate_shift_entries.join(PATTERN_ENTRY)
	end
end

class Entry
	include Helper
	
	attr_accessor :number, :time_start, :time_end, :subtitle

	def initialize number, time, subtitle
		@number = number
		@time_start, @time_end = divide_time time
		@subtitle = subtitle
	end
end

=begin
	Iteration 1: true
	Iteration 2: false (todo)
	Iteration 3: true
=end

srt = SRT.new 'Source.srt'
srt.load_file
srt.backwards 1000
srt.generate_new_file 'Target.srt'