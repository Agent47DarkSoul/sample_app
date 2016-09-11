class Identity < ActiveRecord::Base
  belongs_to :user
  attr_accessible :access_token, :provider, :uid
end
