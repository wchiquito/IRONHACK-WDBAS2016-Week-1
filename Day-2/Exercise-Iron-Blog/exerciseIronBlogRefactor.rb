class Blog
	def initialize
		@posts = []
	end

	def add_post post
		@posts.push post
	end

	def order_by_date
		@posts.sort! { |pre, cur| cur.date <=> pre.date }
	end

	def pagination page
		new_page = 0, number_of_pages = []
		if @posts.length > 3
			len = @posts.length
			pages = len / 3
			if len.modulo(3) != 0
				pages += 1
			end
			if pages > 1
				puts ''
				pages.times do |n_page|
					number_of_pages.push (n_page + 1).to_s + (n_page == page -1 ? '*' : '')
				end
				puts number_of_pages.join('   ')
				puts ''
				puts '0 = Exit!'
				puts ''
				print "> "
				new_page = gets.chomp.to_i
				if new_page <= -1 || new_page > pages
					new_page = page
				end
			end
		end
		new_page
	end
	
	def show_front_page page
		while (page > 0)
			init_element_in_posts = (page * 3) - 3
			posts_to_show = @posts[init_element_in_posts, 3]
			if !posts_to_show.nil?
				posts_to_show.each_with_index do |post, index|
					post.print init_element_in_posts + index + 1
				end
			end
			page = pagination page
		end
	end

	def publish_front_page
		order_by_date
		show_front_page 1
	end
end

class Post
	attr_reader :title, :text, :date, :sponsored

	def initialize 	title, text, sponsored = false
		@title = title
		@text = text
		@sponsored = sponsored
		@date = Time.now - (rand * 86400 * 30)
	end

	def print index
		title = "Post #{self.title}"
		if self.sponsored
			title = "******#{title}******"
		end
		puts "#{title}\n**************\nPost #{index} #{self.text}\n----------------"
	end
end

blog = Blog.new
blog.add_post Post.new 'title 1', 'text'
blog.add_post Post.new 'title 2', 'text'
blog.add_post Post.new 'title 3', 'text', true
blog.add_post Post.new 'title 4', 'text'
blog.add_post Post.new 'title 5', 'text'
blog.add_post Post.new 'title 6', 'text'
blog.add_post Post.new 'title 7', 'text'
blog.add_post Post.new 'title 8', 'text'
blog.add_post Post.new 'title 9', 'text'
blog.add_post Post.new 'title 10', 'text', true
blog.add_post Post.new 'title 11', 'text'
blog.add_post Post.new 'title 12', 'text'
blog.add_post Post.new 'title 13', 'text'
blog.add_post Post.new 'title 14', 'text'
blog.publish_front_page