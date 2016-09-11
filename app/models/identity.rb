class Identity < ActiveRecord::Base
  belongs_to :user
  attr_accessible :access_token, :provider, :uid

  def provider_name
    self.provider.to_s.titleize
  end
end
