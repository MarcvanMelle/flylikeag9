require 'rails_helper'

feature "User can sign in with a third party authentication service (ie facebook, github, etc)" do
  before { visit root_path }
  context "As an unauthenticated user" do
    scenario "I can see sign-in buttons for supported services" do
      expect(page).to have_link("Sign in with Github")
      expect(page).to have_link("Sign in with Facebook")
    end

    scenario "I can be logged in using my third party credentials" do
      login_with_oauth(:github)

      expect(page).to have_content("Signed in as MightyBeetleBorg")
    end

    scenario "I can be logged in use different auth services" do
      login_with_oauth(:facebook)

      expect(page).to have_content("Signed in as BigBadBeetleBorgs")
    end

    scenario "I can logout after signing in with a service" do
      login_with_oauth(:facebook)
      click_link("Logout")

      expect(page).to have_content("Signed out successfully")
    end

    scenario "If I login through a service with the same email as an account I already own on the site, I am logged in through the site." do
      user = FactoryGirl.create(:user, email: "beetleborgs@gmail.com", username: "WordUpSpecificUsername")
      login_with_oauth(:github)

      expect(page).to have_content("Signed in as #{user.username}")
    end

    scenario "If I login through a service then attempt to log in through a different service, it uses the first created user account" do
      login_with_oauth(:github)
      expect(page).to have_content("Signed in as MightyBeetleBorg")

      click_link("Logout")

      login_with_oauth(:facebook)
      expect(page).to have_content("Signed in as MightyBeetleBorg")

    end
  end
end
