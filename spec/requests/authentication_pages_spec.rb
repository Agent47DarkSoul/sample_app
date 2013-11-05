require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }

	describe "GET /signin page" do
		before { get signin_path }

		it "should visit signin page" do
			response.status.should be(200)
		end
	end

	describe "signin page" do
		before { visit signin_path }

		let(:submit) { 'Sign in' }

		it { should have_selector('h1', text: 'Sign in') }
		it { should have_selector('title', text: 'Sign in') }

		describe "with invalid information" do
			before { click_button submit }

			it { should have_selector('title', text: 'Sign in') }
			it { should have_selector('div.alert.alert-error', text: 'invalid') }
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }

			before do
				fill_in "Email", with: user.email
				fill_in "Password", with: user.password
				click_button submit
			end

			it { should have_selector('title', text: user.name) }
			it { should_not have_link("Sign in", href: signin_path) }

			it { should have_link("Profile", href: user_path(user)) }
			it { should have_link("Sign out", href: signout_path) }

			it { should have_link('Settings', href: edit_user_path(user)) }

			describe "followed by signout" do
				before { click_link "Sign out" }

				it { should have_link('Sign in', href: signin_path) }
				it { should_not have_link('Sign out', href: signout_path) }
			end
		end
	end

  describe "authorization" do
    context "for non signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      context "in the Users controller" do
        context "visiting the edit page" do
          before(:each) { visit edit_user_path(user) }
          it { should have_selector('title', :text => 'Sign in') }
        end

        context "submitting to the update action" do
          before(:each) { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end
	end
end
