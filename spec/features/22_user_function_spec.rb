require 'rails_helper'

feature "User can search for word" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:words) { FactoryGirl.create_list(:word, 2, user: user) }

  context "As a user" do
    scenario "I can search for a word" do
      login_as(user, scope: :user)
      visit '/'
      fill_in "search", with: words[0].word
      click_button "Search"

      expect(page).to have_content words[0].word
      expect(page).to_not have_content words[1].word
    end
    scenario "I can search for a partial and get all words that include that partial" do
      login_as(user, scope: :user)
      visit '/'
      fill_in "search", with: "Word"
      click_button "Search"

      expect(page).to have_content words[0].word
      expect(page).to have_content words[1].word
    end
    scenario "I can navigate to a word's show page after searching for that word" do
      login_as(user, scope: :user)
      visit '/'
      fill_in "search", with: words[0].word
      click_button "Search"

      click_link words[0].word
      expect(page).to have_content words[0].word
      expect(page).to have_content words[0].definition
    end
    scenario "If I search for a word that does not exist, I should get an error message" do
      login_as(user, scope: :user)
      visit '/'
      fill_in "search", with: "Cup"
      click_button "Search"

      expect(page).to have_content "Word could not be found"
    end
    scenario "If I press search without entering anything in the form field, I should get an error message" do
      login_as(user, scope: :user)
      visit '/'
      click_button "Search"

      expect(page).to have_content "You must enter something"
    end
  end
end
