require 'spec_helper'

feature "User profile" do
  Steps "Own profile" do
    Given "I am a registered user" do
      @user = create(:user)
    end

    When "I visit my profile page" do
      visit user_path(@user)
    end

    Then "I should see my picture and name" do
      expect(page).to have_selector('h1', :text => @user.name)
      expect(page).to have_selector('img')
    end
  end
end