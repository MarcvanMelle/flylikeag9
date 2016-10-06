require 'rails_helper'

feature "Admin can update word" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:word) { FactoryGirl.create(:word, user: users[0]) }
  before { visit root_path }
  context "As an admin" do
    scenario "I can update any word" do
      login_as(admin, scope: :user)
      visit word_path(word)
      click_link "Update Content"
      fill_in("Definition", with: "randumb new definition")
      click_button("Update Word")

      expect(page).to have_content "randumb new definition"
    end
  end

  context "As non-admin authenticated user" do
    scenario "I cannot curl into the word update action" do
      login_as(users[1], scope: :user)
      page.driver.submit :patch, "/words/#{word.id}", { word: { definition: "I'm a hacker" } }

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end
end
