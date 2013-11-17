require 'spec_helper'

describe "Users API" do
  describe "signup" do
    context "with valid user details" do
      it "creates new user, signs in user and redirects to User's page" do
        get new_user_path
        expect(response).to render_template(:new)

        user = build(:user)
        post users_path, :user => {
          :name => user.name,
          :email => user.email,
          :password => user.password,
          :password_confirmation => user.password_confirmation
        }

        expect(response).to redirect_to(assigns(:user))

        follow_redirect!

        expect(response).to render_template('users/show')
      end
    end

    context "with invalid user details" do
      it "renders new page with errors" do
        user = build(:user)
        post users_path, :user => {
          :name => user.name,
          :password => user.password,
          :password_confirmation => user.password_confirmation
        }

        expect(response).to render_template('users/new')
        expect(response.body).to include('error')
      end
    end
  end

  describe "profile" do
    it "returns OK response" do
      user = create(:user)

      get user_path(user)

      expect(response).to be_ok
    end
  end

  describe "profile edit" do
    context "when current user is different than profile user" do
      it "shows user's profile" do
        user = create(:user)
        another_user = create(:user)
        sign_in(another_user.remember_token)

        get edit_user_path(user)

        expect(response).to redirect_to(user)
      end
    end
  end

  describe "profile update" do
    let(:user) { create(:user) }

    context "when current user is same as profile user" do
      before(:each) do
        sign_in(user.remember_token)
      end

      context "with invalid information" do
        it "does not update the user and returns error messages" do
          put user_path(user), :user => {
            :name => "", :email => "person@example.com"
          }

          expect(response).not_to redirect_to(assigns(:user))

          expect(response.body).to include("error")
        end
      end

      context "with valid information" do
        it "updates user and redirects to User's page" do
          put user_path(user), :user => {
            :name => "New Name", :email => "person@example.com",
            :password => "new_password",
            :password_confirmation => "new_password"
          }

          expect(response).to redirect_to(assigns(:user))

          follow_redirect!

          expect(response.body).to include("New Name")

          sign_in user.remember_token
          expect(response.body).to include("New Name")
        end
      end
    end

    context "when current user is different than profile user" do
      it "redirects to current user's profile edit page" do
        another_user = create(:user)
        sign_in another_user.remember_token

        put user_path(user), :user => {
          :name => "New Name", :email => "new_email@example.com",
          :password => "new_password",
          :password_confirmation => "new_password"
        }

        expect(response).to redirect_to(edit_user_path(another_user))

        sign_in user.remember_token
        get user_path(user)
        expect(response).not_to include('New Name')
      end
    end
  end
end