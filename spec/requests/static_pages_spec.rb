require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
    	visit root_path
    	page.should have_selector('h1', :text => 'Sample App')
    end

    it "should have the correct title" do
    	visit root_path
    	page.should have_selector('title', :text => 'Ruby on Rails Tutorials Sample App')
    end

    it "should not have 'Home' in the title" do
    	visit root_path
    	page.should_not have_selector('title', :text => 'Home')
    end
  end

  describe "Help page" do
  	it "should have the content 'Help'" do
  		visit help_path
  		page.should have_content('Help')
  	end

  	it "should have the correct title" do
    	visit help_path
    	page.should have_selector('title', :text => ' | Help')
    end
  end

  describe "About page" do
  	it "should have the content 'About'" do
  		visit about_path
  		page.should have_content('About')
  	end

  	it "should have the correct title" do
    	visit about_path
    	page.should have_selector('title', :text => ' | About')
    end
  end

  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit contact_path
      page.should have_content('Contact Us')
    end

    it "should have the correct title" do
      visit contact_path
      page.should have_selector('title', :text => ' | Contact Us')
    end
  end
end