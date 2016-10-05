require 'rails_helper'

feature "User can logout" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  context "As a user I can go to any page" do
    scenario "and I can logout" do
      visit '/'
      click_link("Logout")

      expect(page).to have_content("Signed out successfully.")
      expect(page).to have_content("Login-Email")
      expect(page).to have_field("Login-Email")
      expect(page).to have_content("Login-Password")
      expect(page).to have_field("Login-Password")
      expect(page).to have_button("Sign in")
      expect(page).to have_link("Forgot your password?")
      expect(page).to have_link("Sign up")
      expect(page).to have_content("Remember me")
    end
  end
end
