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
end