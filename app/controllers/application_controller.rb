class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def authenticate_user!
    unless signed_in?
      redirect_to signin_path
    end
  end
end
