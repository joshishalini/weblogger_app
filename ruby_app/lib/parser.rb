require 'pry'

class Parser

	attr_reader :data, :path

	def initialize(file_path)
		check_file(file_path)
		@data = Hash.new { |h, k| h[k] = {ip: [], count: 0} }
		@path = file_path
	end

	def parse
		File.open(@path).each do |row|
			page, ip = row.split(" ")
			unless page && ip
				raise "Wrong file."
			end
			if !@data[page][:ip].include?(ip)
				@data[page][:ip].push(ip)
			end
			@data[page][:count] = @data[page][:count] + 1 
		end
		@data
	end

	def unique_pages
		print_data( @data.sort_by{|key, val| val[:ip].count}.reverse, "most unique")
	end

	def most_visited_pages
		print_data(@data.sort_by{|key, val| val[:count]}.reverse, "most page views")
	end

	private

	def check_file(path)
		raise "File not present." unless File.exist?(path)
	end

	def print_data(data, type)
		puts "--"*10 + " list of webpages with #{type} page " + "--"*10
		data.each do |row|
			count = type == "most unique" ? row.last[:ip].count : row.last[:count]
			puts "#{row.first} #{count} Unique views"
		end
	end
end

# parser = Parser.new(ARGV[0])
# parser.parse
# parser.unique_pages
# parser.most_visited_pages