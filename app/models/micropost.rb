class Micropost < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :user

  validates :content, :length => { :maximum => 140 }
end
