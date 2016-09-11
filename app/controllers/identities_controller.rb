class IdentitiesController < ApplicationController
  before_filter :authenticate_user!

  def create
    identity = current_user.identities.find_or_create_by!(identity_info_hash)

    flash[:notice] = "#{identity.provider_name} account connected successfully."
    redirect_to alternate_redirect_path || root_path
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_params
    request.env['omniauth.params']
  end

  def alternate_redirect_path
    (auth_params && auth_params['redirect_to']) || params['redirect_to']
  end

  def identity_info_hash
    { provider: auth_hash['provider'],
      uid: auth_hash['uid'],
      access_token: auth_hash['credentials']['token'] }
  end
end
