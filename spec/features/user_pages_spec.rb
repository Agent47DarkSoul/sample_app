require 'spec_helper'

describe "UserPages" do

	subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_title(user.name) }
  end

  describe "profile update" do
    let(:user) { FactoryGirl.create(:user) }
    let(:submit) { "Save changes" }
    let(:update_h1_text) { 'Update your profile' }

    after(:each) { sign_out_from_ui }

    context "when current user is same as profile user" do
      before(:each) do
        sign_in_from_ui user
        visit edit_user_path(user)
      end

      describe "page" do
        it { should have_selector('h1', :text => update_h1_text) }
        it { should have_title('Edit user') }
        it { should have_link('change', :href => 'http://en.gravatar.com/emails') }
      end

      context "with invalid information" do
        it "should not update the user" do
          expect { click_button submit }.not_to change(user, :updated_at)
        end

        context "after submission" do
          before { click_button submit }

          it { should have_selector('h1', :text => update_h1_text) }
          it { should have_content('error') }
        end
      end

      context "with valid information" do
        let(:new_name) { "New Name" }
        let(:new_email) { "new@email.com" }

        before(:each) do
          fill_in "Name", :with => new_name
          fill_in "Email", :with => new_email
          fill_in "Password", :with => user.password
          fill_in "Confirmation", :with => user.password

          click_button submit
        end

        it { should have_title(new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', :href => signout_path) }

        specify { user.reload.name = new_name }
        specify { user.reload.email = new_email }
      end
    end

    # TODO: This test belongs in request spec, as a user will
    # never have a link to edit other user.
    context "when current user is different than profile user" do
      it "shows user's profile" do
        another_user = create(:user)
        sign_in_from_ui another_user
        visit edit_user_path(user)

        # TODO: Use common test
        expect(page).to have_selector('h1', :text => user.name)
        expect(page).to have_title(user.name)
      end
    end
  end
end
