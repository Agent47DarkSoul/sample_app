require 'spec_helper'

feature "User profile update" do
  let(:email) { "person@example.com" }
  let(:password) { "sample_password" }

  background do
    create(:user,
      :email => email,
      :password => password,
      :password_confirmation => password
    )
  end

  shared_steps "I am signed in" do
    Given "I am signed in" do
      sign_in_from_ui(email, password)
    end
  end

  Steps "Successful" do
    include_steps "I am signed in"

    When "I update my profile with valid new details" do
      click_on "Settings"

      fill_in 'Name', :with => "New Name"
      fill_in 'Email', :with => "new_email@example.com"
      fill_in 'Password', :with => "new_password"
      fill_in 'Confirmation', :with => "new_password"
      click_button 'Save changes'
    end

    Then "I should see a success message" do
      expect(page).to have_selector('.alert-success', :text => "Profile has been updated")
    end

    And "It updates my profile details" do
      sign_out_from_ui

      sign_in_from_ui("new_email@example.com", "new_password")
      expect(page).to have_selector('h1', :text => "New Name")
    end
  end

  Steps "Failure" do
    include_steps "I am signed in"

    When "I update my details with invalid new details" do
      click_on "Settings"

      fill_in 'Name', :with => ""
      fill_in 'Email', :with => "new_email@example.com"
      fill_in 'Password', :with => "wrong_password"
      fill_in 'Confirmation', :with => "new_password"
      click_button 'Save changes'
    end

    Then "I should be shown error messages" do
      within('form') { expect(page).to have_content('errors') }
    end

    And "My profile details should not be updated" do
      sign_out_from_ui

      sign_in_from_ui "new_email@example.com", "wrong_password"
      expect(page).to have_title('Sign in')
    end
  end
end