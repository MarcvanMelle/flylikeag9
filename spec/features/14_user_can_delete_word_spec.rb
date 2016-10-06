require 'rails_helper'

feature "User can delete word they created" do
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:word) { FactoryGirl.create(:word, user: users[0]) }
  before { visit root_path }
  context "As an authenticated user" do
    scenario "I can delete a word I created" do
      login_as(users[0], scope: :user)
      visit word_path(word)
      click_link "Delete Word"

      expect(page).to have_no_content word.word
    end

    scenario "I can't see a delete button for a word I didn't create" do
      login_as(users[1], scope: :user)
      visit word_path(word)

      expect(page).to have_no_link "Delete Word"
    end

    scenario "I can't curl into delete method for a word I did not create" do
      login_as(users[1], scope: :user)
      visit word_path(word)
      page.driver.submit :delete, "/words/#{word.id}", {}

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end

  context "As an unauthenticated user" do
    scenario "I cannot see a delete link" do
      expect(page).to have_no_link "Delete Word"
    end

    scenario "I cannot curl into delete method for a word I did not create" do
      page.driver.submit :delete, "/words/#{word.id}", {}

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end
end
