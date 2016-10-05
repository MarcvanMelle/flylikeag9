require 'rails_helper'

feature "User can reset password" do
  before { visit root_path }
  context "As a user, I forgot my password" do
    scenario "and I see a password reset link " do

      expect(page).to have_link("Forgot your password?")
    end

    scenario "I can navigate to the password reset form" do
      click_link("Forgot your password?")

      expect(page).to have_content("Forgot your password?")
      expect(page).to have_content("Email")
      expect(page).to have_field("Email")
      expect(page).to have_link("Log in")
      expect(page).to have_link("Sign up")
      expect(page).to have_button("Send me reset password instructions")
    end

    scenario "I submit a password reset" do
      user = FactoryGirl.create(:user)
      click_link("Forgot your password?")
      fill_in("Email", with: user.email)
      click_button("Send me reset password instructions")

      expect(page).to have_content("You will receive an email with instructions")
    end

    scenario "I can't submit for a reset without inserting an email" do
      click_link("Forgot your password?")
      click_button("Send me reset password instructions")

      expect(page).to have_no_content("You will receive an email with instructions")
      expect(page).to have_content("Email can't be blank")
    end
  end
end
