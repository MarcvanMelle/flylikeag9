require 'rails_helper'

feature "As an unregistered user, I can create an account" do
  let!(:existing_username) { FactoryGirl.create(:user, username: "ButtonBoy01") }
  let!(:existing_user_email) { FactoryGirl.create(:user, email: "grapesApedude01@gmail.com") }
  before { visit new_user_registration_path }
  context "User navigates to sign up page" do
    scenario "User sees a page with sign up information" do
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
  end

  context "User successfully signs up" do
    scenario "User fills out all fields correctly" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")

      click_button("Sign up")
      expect(page).to have_content("pup")
    end
  end

  context "User provides incomplete information" do
    scenario "User leaves username blank" do
      fill_in("Username", with: "")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")

      click_button("Sign up")
      expect(page).to have_content("Username can't be blank")
    end

    scenario "User leaves email blank" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")

      click_button("Sign up")
      expect(page).to have_content("Email can't be blank")
    end

    scenario "User leaves both password fields blank" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "")
      fill_in("Password confirmation", with: "")

      click_button("Sign up")
      expect(page).to have_content("Password can't be blank")
    end

    scenario "User leaves password confirmation field blank" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "")

      click_button("Sign up")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  context "User provides invalid information" do
    scenario "User provides an invalid email" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")

      click_button("Sign up")
      expect(page).to have_content("Email is invalid")
    end

    scenario "User provides mismatched passwords" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abcedf1")
      fill_in("Password confirmation", with: "abcedf2")

      click_button("Sign up")
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    scenario "User provides an existing email" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude01@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")

      click_button("Sign up")
      expect(page).to have_content("Email has already been taken")
    end

    scenario "User provides an existing username" do
      fill_in("Username", with: "ButtonBoy01")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")

      click_button("Sign up")
      expect(page).to have_content("Username has already been taken")
    end

    scenario "User provides a password less than 6 characters" do
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abced")
      fill_in("Password confirmation", with: "abced")

      click_button("Sign up")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end
  end
end
