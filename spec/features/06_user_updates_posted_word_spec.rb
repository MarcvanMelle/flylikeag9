require 'rails_helper'

feature "User updates a word they posted" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user) }
  let!(:word2) { FactoryGirl.create(:word, user: user) }
  before { visit word_path(word1) }


  context "As a user" do
    scenario "I can click a link to go to my word's update page" do
      fill_in("Login-Email", with: user.email)
      fill_in("Login-Password", with: user.password)
      check("Remember me")
      click_button("Sign in")
      visit word_path(word1)
      click_link "Update Content"

      save_and_open_page
      expect(page).to have_content word1.word
      expect(page).to have_field "Definition"
      expect(page).to have_button "Update Word"
    end
  end
end
