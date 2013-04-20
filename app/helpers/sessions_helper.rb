module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		current_user = user
	end

	def signed_in?
		current_user.present?
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.where(remember_token: cookies[:remember_token]).first
	end
end
