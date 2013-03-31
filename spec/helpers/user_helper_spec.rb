require 'spec_helper'

describe UsersHelper do
	describe "gravatar_for" do
		let(:user) { 
			User.new name: "Test User", email: "user@test.com", 
							 password: "sample", password_confirmation: "sample"
		}

		it "should take optional size parameter" do
			gravatar_for(user, size: 80).should =~ /img/
		end

		it "should return img with right size" do
			gravatar_for(user, size: 80).should =~ /s=80/
 		end
	end
end