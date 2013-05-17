class Post < ActiveRecord::Base
	has_many :post_tags
	has_many :tags, :through => :post_tags, :uniq => true
	belongs_to :user
	belongs_to :blog
	
	def format_body(text)
		text.gsub(/(\\r\\n\\r\\n)/,"$$$")
	end

	def add_tags(tags)
		tags = tags.split(/,/)
		tags.each { |tag| self.tags << Tag.find_or_create_by_name(tag.strip) }
	end

	def tags_as_string
		tag_string = ""
		self.tags.each { |tag| tag_string << tag.name + ", "}
		tag_string.strip
	end

	def self.search_posts(search_string)
		results = []
		self.all.each { |post| results << post if post.title.match(/#{search_string}/i) || post.body.match(/#{search_string}/i) }
		results
	end
end
