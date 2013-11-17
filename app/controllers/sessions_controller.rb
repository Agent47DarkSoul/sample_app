class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.where(email: params[:session][:email]).first

    if @user && @user.authenticate(params[:session][:password])
      # sign in the user and redirect to the user's profile page
      sign_in @user
      redirect_to user_path(@user)
    else
      flash[:error] = "You have entered invalid username/password"
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
