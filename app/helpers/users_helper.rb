module UsersHelper
	
	# Public: Returns the gravatar for given user
	# 
	# user - The User model instance for which gravatar is required
	# 
	# Examples
	# 	gravatar_for(user)
	# 	# => <img url="https://secure.gravatar.com/avatar/6a0eec8b11d194b121ea5b84c5fd88c5" alt="Danish Satkut" class="gravatar">
	# 	
	# Returns the img tag with the gravatar image for the user
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end
end
