class MicropostsController < ApplicationController
  def new
    @micropost = Micropost.new
  end

  def create
    @micropost = Micropost.new(params[:micropost])
    @micropost.user = current_user

    if @micropost.save
      flash[:success] = "Status posted"
      redirect_to current_user
    else
      flash[:error] = "Status is over 140 characters"
      render :new
    end
  end
end
