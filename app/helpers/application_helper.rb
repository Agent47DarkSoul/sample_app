module ApplicationHelper
	# Returns the title on per page basis
	def full_title(page_title)
		base_title = 'Ruby on Rails Tutotials Sample App'
		return page_title.empty? ? base_title : "#{base_title} | #{page_title}"
	end
end
