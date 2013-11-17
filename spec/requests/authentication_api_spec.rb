require 'spec_helper'

describe "Authentication API" do
  describe "sign in" do
    shared_examples "sign in failure" do
      it "redirects to signin page with error message" do
        post sessions_path, :session => {
          :email => user.email, :password => "123456"
        }

        expect(response).to redirect_to(signin_path)
        expect(flash[:error]).to match(/invalid username\/password/)
      end
    end

    context "when user is available in database" do
      let(:user) { create(:user) }

      context "when user name and password is correct" do
        it "signs in user and redirects to user's profile page" do
          post sessions_path, :session => {
            :email => user.email, :password => user.password
          }

          expect(response).to redirect_to(assigns(:user))
          expect(cookies["remember_token"]).to eq(user.remember_token)

          follow_redirect!

          expect(response).to render_template(:show)
        end
      end

      context "when user name or password is incorrect" do
        include_examples "sign in failure"
      end
    end

    context "when user is not available in database" do
      let(:user) { build_stubbed(:user) }

      include_examples "sign in failure"
    end
  end

  describe "sign out" do
    it "signs out user and redirects to root page" do
      user = create(:user)
      sign_in(user)

      delete signout_path

      expect(cookies["remember_token"]).not_to be_present
      expect(response).to redirect_to(root_path)
    end
  end
end