require 'rails_helper'

feature "Admin can delete word" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:user) { FactoryGirl.create_list(:user, 2) }
  let!(:word) { FactoryGirl.create(:word, user: user[0]) }
  before { visit root_path }
  context "As an admin" do
    scenario "I can navigate to a word's page and delete it" do
      login_as(admin, scope: :user)
      click_link word.word
      click_link "Delete Word"

      expect(page).to have_no_link word.word
    end
  end

  context "As an non-admin, user" do
    scenario "I cannot delete a word that is not mine" do
      login_as(user[1], scope: :user)
      page.driver.submit :delete, "/words/#{word.id}", {}
      save_and_open_page

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end
end
