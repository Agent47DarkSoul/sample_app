class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		user = User.where(email: params[:session][:email]).first

		if user && user.authenticate(params[:session][:password])
			# Authenticated
			# redirect to home
			redirect_to user_path(user)
		else
			flash[:error] = "You have entered invalid username/password"
			redirect_to signin_path
		end
	end

	def destroy
		
	end
end
