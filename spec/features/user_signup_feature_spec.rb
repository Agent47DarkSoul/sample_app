require 'spec_helper'

feature "User signup" do
  let(:submit) { "Create my account" }

  shared_steps "I want to sign up" do
    Given "I want to sign up" do
      visit signup_path
      expect(page).to have_selector('h1', text: "Sign up")
      expect(page).to have_title(full_title('Signup'))
    end
  end

  context "with valid user information" do
    Steps "is successful" do
      include_steps "I want to sign up"

      When "I sign up with valid details" do
        new_user = build(:user)
        fill_in_signup_form_with(new_user)
      end

      Then "I should be signed up" do
        expect { click_button submit }.to change(User, :count)
      end

      And "I should see welcome message" do
        expect(page).to have_selector('div.alert.alert-success', text: 'Welcome')
      end
    end
  end

  context "with invalid user information" do
    Steps "fails when email is already used by another account" do
      include_steps "I want to sign up"

      But "I enter an email address that has been already registered" do
        existing_user = create(:user)
        new_user = build(:user, :email => existing_user.email)
        fill_in_signup_form_with(new_user)
      end

      Then "I should not be signed up" do
        expect { click_button submit }.not_to change(User, :count)
      end

      And "I should receive error message for duplicate email" do
        expect(page).to have_selector('div.alert.alert-error')
        expect(page).to have_selector('li', text: "Email has already been taken")
      end
    end

    Steps "fails when password is less than 6 characters" do
      include_steps "I want to sign up"

      But "I enter password less than 6 characters" do
        new_user = build(:user, :password => '1234', :password_confirmation => '1234')
        fill_in_signup_form_with(new_user)
      end

      Then "I should not be signed up" do
        expect { click_button submit }.not_to change(User, :count)
      end

      And "I should receive error message for short password" do
        expect(page).to have_selector('div.alert.alert-error')
        expect(page).to have_selector('li', text: "Password is too short")
      end
    end

    Steps "fails when password does not match confirmation password" do
      include_steps "I want to sign up"

      But "I enter different confirmation password" do
        new_user = build(:user, :password => 'foobarawesome', :password_confirmation => '12345')
        fill_in_signup_form_with(new_user)
      end

      Then "I should not be signed up" do
        expect { click_button submit }.not_to change(User, :count)
      end

      And "I should receive password confirmation mismatch error" do
        expect(page).to have_selector('div.alert.alert-error')
        expect(page).to have_selector('li', text: "Password doesn't match confirmation")
      end
    end
  end

  def fill_in_signup_form_with(user)
    fill_in "Name", with: user.name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Confirmation", with: user.password_confirmation
  end
end