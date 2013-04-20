require 'spec_helper'

describe User do
  before { @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate)}

  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @user.name = "" }

  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = "" }

  	it { should_not be_valid }
  end

  describe "when name is less than 50 characters" do
  	before { @user.name = "a" * 49 }

  	it { should be_valid }
  end

  describe "when name is exactly 50 characters" do
  	before { @user.name = "a" * 50 }

  	it { should be_valid }
  end

  describe "when name is longer than 50 characters" do
  	before { @user.name = "a" * 51 }

  	it { should_not be_valid }
  end

  describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[danish_satkut@hotmail.com abc.def@example.com]

  		addresses.each do |address|
  			@user.email = address
  			@user.should be_valid
  		end
  	end
  end

  describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
					foo@bar_baz.com foo@bar+baz.com]

		addresses.each do |address|
			@user.email = address
			@user.should_not be_valid
		end
  	end
  end

  describe "when email is already taken" do
  	before do
  		user_with_same_email = @user.dup
  		user_with_same_email.email = @user.email.downcase
  		user_with_same_email.save
  	end

  	it { should_not be_valid }
  end

  describe "when password is not present" do
  	before { @user.password = @user.password_confirmation = "" }
  	it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "when password_confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  	before { @user.save }

  	let(:found_user) { User.find_by_email(@user.email) }

  	describe "with valid password" do
  		it { should == found_user.authenticate(@user.password) }
  	end

  	describe "with invalid password" do
  		let(:user_for_invalid_password) { found_user.authenticate("fake password") }

  		it { should_not == user_for_invalid_password }

  		specify { user_for_invalid_password.should be_false }
  	end
  end

  describe "with a password too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }

  	it { should_not be_valid }
  end

  describe "with email address with mixed case" do
  	let(:mixed_case_email) { "uSEr@ExaMPLe.COm" }

  	it "should be saved as all lower case code" do
  		@user.email = mixed_case_email
  		@user.save
  		@user.reload.email.should == mixed_case_email.downcase
  	end
  end

  describe "remember token" do
    before { @user.save }

    its(:remember_token) { should_not be_blank }
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

