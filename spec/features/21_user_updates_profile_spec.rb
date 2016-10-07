require 'rails_helper'

feature "User can update their profile" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  context "As an authenticated user" do
    scenario "I can update my user password" do
      login_as(users[0], scope: :user)
      visit user_path(users[0])
      click_link "Edit your account"
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      fill_in "Current password", with: users[0].password
      click_button "Update"
      click_link "Logout"
      fill_in "Login-Email", with: users[0].email
      fill_in "Login-Password", with: "password1"
      click_button "Sign in"

      expect(page).to have_content "Signed in as #{users[0].username}"
    end

    scenario "I can update my user email" do
      login_as(users[0], scope: :user)
      visit user_path(users[0])
      click_link "Edit your account"
      fill_in "Email", with: "hello1@hotmail.com"
      fill_in "Current password", with: users[0].password
      click_button "Update"
      click_link "Logout"
      fill_in "Login-Email", with: "hello1@hotmail.com"
      fill_in "Login-Password", with: users[0].password
      click_button "Sign in"

      expect(page).to have_content "Signed in as #{users[0].username}"
    end

    scenario "I cannot edit another user's profile" do
      login_as(users[0], scope: :user)
      visit user_path(users[1])

      expect(page).to_not have_content "Edit your account"
    end

  end
end
