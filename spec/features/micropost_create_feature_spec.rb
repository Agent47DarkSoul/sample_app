require 'spec_helper'

feature "Status Post" do
  let(:email) { "person@example.com" }
  let(:password) { "validpassword" }

  let(:user) { create(:user, :with_password, :email => email, :password => password) }

  shared_steps "for user signed in" do
    Given "I am a signed in user" do
      sign_in_from_ui(user.email, user.password)
    end
  end

  Steps "status is less than or equal to 140 characters" do
    include_steps "for user signed in"

    When "I post a status with 140 or less characters" do
      visit new_micropost_path
      fill_in "Content", :with => "This is a sample status"
      click_button "Post"
    end

    Then "I should see the posted status on my profile" do
      profile_page_for(user)      # Create a matcher for checking this profile page
      expect(page).to have_selector("li", :text => "This is a sample status")
    end

    And "I should see notification for new status created" do
      expect(page).to have_selector('.alert-success', :text => 'posted')
    end
  end

  Steps "status is over 140 characters" do
    include_steps "for user signed in"

    When "I create a micropost with more than 140 characters" do
      visit new_micropost_path
      fill_in "Content", :with => "a" * 141
      click_button "Post"
    end

    Then "I my status should not be posted" do
      expect(page).to have_selector('form')
    end

    And "I should see error message" do
      expect(page).to have_selector('.alert-error', :text => "over 140 characters")
    end
  end
end