require 'rails_helper'

feature "User visits word page" do
  let!(:user) { FactoryGirl.create(:user)}
  let!(:word) { FactoryGirl.create(:word, user: user) }
  context "As a user" do
    scenario "I can click on a word on the home page and be taken to the word's page" do
      visit root_path
      click_link word.word

      expect(page).to have_content word.word
      expect(page).to have_content word.definition
    end

    scenario "I can click on a word on the index page and be taken to the word's page" do
      visit words_path
      click_link word.word

      expect(page).to have_content word.word
      expect(page).to have_content word.definition
    end
  end
end
