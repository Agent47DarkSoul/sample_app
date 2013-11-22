require 'spec_helper'

feature 'User sign in' do
  let(:email) { "person@example.org" }
  let(:password) { 'sample123' }

  shared_steps "for registered user" do
    Given "I am a registered user" do
      create(:user, :with_password, :name => "Sample Person",
        :email => email,
        :password => 'sample123'
      )
    end
  end

  Steps "Successful" do
    include_steps "for registered user"

    When "I submit my signin details" do
      sign_in_from_ui(email, password)
    end

    Then "I should be signed in" do
      expect(page).not_to have_content('Sign in')
    end

    And "I should be taken to my profile page" do
      expect(page).to have_selector('h1', :text => "Sample Person")
    end
  end

  Steps "Unsuccessful" do
    include_steps "for registered user"

    When "I sign in with wrong email or password" do
      sign_in_from_ui(email, 'wrong_password')
    end

    Then "I should not be signed in" do
      expect(page).to have_content('Sign in')
    end

    And "I should see an error message" do
      expect(page).to have_selector('.alert-error', :text => 'invalid username/password')
    end
  end
end