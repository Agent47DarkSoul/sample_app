class UsersController < ApplicationController
	before_filter :authenticate_user!, :only => [:edit, :update]

	def show
		@user = User.find(params[:id])
		@statuses = @user.statuses
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])

		if @user.save
			flash[:success] = "Welcome to Sample App!"
			sign_in @user
			redirect_to @user
		else
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])

		unless current_user.id == @user.id
			redirect_to @user and return
		end
	end

	def update
		@user = User.find(params[:id])

		unless @user.id == current_user.id
			redirect_to edit_user_path(current_user) and return
		end

		if @user.update_attributes(params[:user])
			flash[:success] = "Profile has been updated"
			sign_in(@user)
			redirect_to user_path(@user)
		else
			render :edit
		end
	end
end
