require 'rails_helper'

feature "As an unauthenticated user, I can log in" do
  before { visit root_path }
  let!(:user) { FactoryGirl.create(:user, username: "TimHeidecker", email: "TomPeters@gmail.com", password: "RickWareheimer", password_confirmation: "RickWareheimer") }
  context "User visits the home page" do
    scenario "User sees a page with log in information" do
      expect(page).to have_content("Login-Email")
      expect(page).to have_field("Login-Email")
      expect(page).to have_content("Login-Password")
      expect(page).to have_field("Login-Password")
      expect(page).to have_button("Sign in")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_link("Sign up")
      expect(page).to have_content("Remember me")
    end

    scenario "User successfully logs in" do
      fill_in("Login-Email", with: user.email)
      fill_in("Login-Password", with: user.password)
      check("Remember me")
      click_button("Sign in")

      expect(page).to have_content("Signed in as #{user.username}")
      expect(page).to_not have_content("Login-Email")
      expect(page).to_not have_field("Login-Email")
      expect(page).to_not have_content("Login-Password")
      expect(page).to_not have_field("Login-Password")
      expect(page).to_not have_button("Sign in")
      expect(page).to_not have_link("Forgot your password?")
      expect(page).to_not have_content("Remember me")
    end

    scenario "User attempts to log in with a nonexistent account" do
      fill_in("Login-Email", with: "plumbus@gmail.com")
      fill_in("Login-Password", with: "meeseeks")
      check("Remember me")
      click_button("Sign in")

      expect(page).to have_content("You must create an account to sign in.")
      expect(page).to have_content("Sign up")
      expect(page).to have_content("Username")
      expect(page).to have_field("Username")
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_content("Password confirmation")
      expect(page).to have_field("Password confirmation")
      expect(page).to have_button("Sign up")
      expect(page).to have_link("Log in")
    end

    scenario "User attempts to log in with an incorrect password" do
      fill_in("Login-Email", with: user.email)
      fill_in("Login-Password", with: "RickHeingeber")
      click_button("Sign in")

      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page.find("#user_email")['value']).to eq(user.email)
      expect(page).to have_content("Password")
      expect(page).to have_field("Password")
      expect(page).to have_button("Log in")
      expect(page).to have_link("Sign up")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_content("Remember me")
    end
  end
end
