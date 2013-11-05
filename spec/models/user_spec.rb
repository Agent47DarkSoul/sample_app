require 'spec_helper'

describe User do
  let(:user) { build(:user) }

  it "responds to authenticate" do
    expect(user).to respond_to(:authenticate)
  end

  context "with all attributes present" do
    it "is valid" do
      expect(user).to be_valid
    end
  end

  context "when name is not present" do
    it "is not valid" do
      user.name = ''
      expect(user).not_to be_valid
    end
  end

  context "when email is not present" do
    it "is not valid" do
      user.email = ''
      expect(user).not_to be_valid
    end
  end

  context "when name is less than 50 characters" do
    it "is valid" do
      user.name = "a" * 49
      expect(user).to be_valid
    end
  end

  context "when name is exactly 50 characters" do
    it "is valid" do
      user.name = "a" * 50
      expect(user).to be_valid
    end
  end

  context "when name is longer than 50 characters" do
    it "is not valid" do
      user.name = "a" * 51
      expect(user).not_to be_valid
    end
  end

  context "when email format is valid" do
    it "is valid" do
      addresses = %w[danish_satkut@hotmail.com abc.def@example.com]

      addresses.each do |address|
        user.email = address
        expect(user).to be_valid
      end
    end
  end

  context "when email format is invalid" do
    it "is not valid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
        foo@bar_baz.com foo@bar+baz.com]

      addresses.each do |address|
        user.email = address
        expect(user).not_to be_valid
      end
    end
  end

  context "when email is already taken" do
    it "is not valid" do
      another_user = build(:user, :email => user.email)
      another_user.save

      expect(user).not_to be_valid
    end
  end

  context "when password is not present" do
    it "is not valid" do
      user.password = user.password_confirmation = ""
      expect(user).not_to be_valid
    end
  end

  context "when password doesn't match confirmation" do
    it "is not valid" do
      user.password_confirmation = "mismatch"
      expect(user).not_to be_valid
    end
  end

  context "when password_confirmation is nil" do
    it "is not valid" do
      user.password_confirmation = nil
      expect(user).not_to be_valid
    end
  end

  context "with a password too short" do
    it "is not valid" do
      user.password = user.password_confirmation = "a" * 5
      expect(user).not_to be_valid
    end
  end

  context "with email address with mixed case" do
    let(:mixed_case_email) { "uSEr@ExaMPLe.COm" }

    it "saves as all lower case code" do
      user.email = mixed_case_email
      user.save
      user.reload

      expect(user.email).to eq(mixed_case_email.downcase)
    end
  end

  describe "remember token" do
    it "is not blank after save" do
      user.save
      expect(user.remember_token).to be_present
    end
  end
end