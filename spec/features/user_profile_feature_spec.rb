require 'spec_helper'

feature "User profile" do
  let(:user) { create(:user) }
  let(:microposts) { create_list(:micropost, 2, :user => user) }

  Steps "Own profile" do
    Given "I am a registered user" do
      user
    end

    And "I have posted statuses" do
      microposts
    end

    When "I visit my profile page" do
      visit user_path(user)
    end

    Then "I should see my picture and name" do
      expect(page).to have_selector('h1', :text => user.name)
      expect(page).to have_selector('img')
    end

    And "I should see all my microposts" do
      microposts.each do |micropost|
        expect(page).to have_selector('li', :text => micropost.content)
      end
    end
  end
end