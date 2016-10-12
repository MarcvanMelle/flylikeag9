require 'rails_helper'

feature "User can navigate using buttons on every page" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:not_user) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user) }
  let!(:word2) { FactoryGirl.create(:word, user: not_user) }
  let!(:review1) { FactoryGirl.create(:review, user: user, word: word1) }
  let!(:review2) { FactoryGirl.create(:review, rating: 2, user: not_user, word: word2) }
  context "As a user" do
    scenario "I click the home button and be brought to the home page" do
      visit word_path(word2)
      expect(page).to have_link("Home")
      click_link("Home")
      expect(page).to have_content("10 Most Recent Words")
    end

    scenario "I click the All Words button and be brought to the words index page" do
      visit word_path(word1)
      expect(page).to have_link("All Words")
      click_link("All Words")
      expect(page).to have_content("All Words on WordUp")
    end
  end
end
