class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  has_secure_password

  before_save { self.email.downcase! }
  before_save :create_remember_token

  has_many :statuses, :class_name => "Micropost"
  has_many :identities, :dependent => :destroy

  def self.find_or_create_by!(identity_info_hash)
    self.where(
      identity_info_hash.slice(:provider, :uid)
    ).first_or_create!(identity_info_hash.slice(:access_token))
  end

	private
	
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)     indexed
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

