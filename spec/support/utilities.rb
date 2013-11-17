include ApplicationHelper

def sign_in_from_ui(email, password)
  visit signin_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

def sign_in(user)
  cookies["remember_token"] = user.remember_token
end

def sign_out_from_ui
  click_link 'Sign out'
end

def sign_out
  cookies.delete("remember_token")
end