require 'rails_helper'

feature "Admin can update word" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:users) { FactoryGirl.create_list(:user, 10) }
  context "As an admin" do
    scenario "I can view an index of users" do
      login_as(admin, scope: :user)
      visit users_path

      users.each do |user|
        expect(page).to have_link(user.username)
      end
    end

    scenario "I can click on a user and visit their profile page" do
      login_as(admin, scope: :user)
      visit users_path

      click_link users[0].username

      expect(page).to have_content("#{users[0].username}'s Profile Page")
      expect(page).to have_content("Submitted Reviews")
      expect(page).to have_content("Submitted Words")
    end
  end

  context "As non-admin authenticated user" do
    scenario "I cannot view the users index" do
      login_as(users[0], scope: :user)
      visit users_path

      expect(page).to have_content "You do not have permission to access this page!"
    end

    scenario "I cannot curl into the users index" do
      login_as(users[1], scope: :user)
      page.driver.submit :get, "/users", {}

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end
end
