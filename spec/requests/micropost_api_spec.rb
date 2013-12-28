require 'spec_helper'

describe "Micropost API" do
  let(:user) { create(:user) }

  describe "micropost creation" do
    context "when user is not signed in" do
      it "redirects to sign in page" do
        get new_micropost_path

        expect(response).to redirect_to(signin_path)
        follow_redirect!

        expect(response.body).to include('Sign in')
      end
    end

    context "when user is signed in" do
      before { sign_in(user.remember_token) }

      it "creates micropost and redirects to current user's profile" do
        get new_micropost_path
        expect(response).to render_template('microposts/new')

        post microposts_path(:micropost => { :content => Faker::Lorem.sentence(10) })
        expect(response).to redirect_to(user)
      end
    end
  end
end
