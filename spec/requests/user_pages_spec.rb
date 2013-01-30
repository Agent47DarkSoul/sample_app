require 'spec_helper'

describe "UserPages" do

	subject { page }

  describe "GET /signup" do
  	before { get signup_path }

    it "should visit signup page" do
    	response.status.should be(200)
  	end
  end

  describe "Signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1', text: "Sign up") }
  	it { should have_selector('title', text: full_title('Signup')) }
  end
end
