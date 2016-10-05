require 'rails_helper'

feature "User updates a word they posted" do
  let!(:user) { FactoryGirl.create_list(:user, 2) }
  let!(:word1) { FactoryGirl.create(:word, user: user[0]) }
  before { visit word_path(word1) }

  context "As an authenticated user who has created the word" do
    scenario "I can click a link to go to my word's update page" do
      login_as(user[0], scope: :user)
      visit word_path(word1)
      click_link "Update Content"

      expect(page).to have_content word1.word
      expect(page).to have_field "Definition"
      expect(page).to have_button "Update Word"
    end

    scenario "On the update page, I can edit the word and save changes" do
      login_as(user[0], scope: :user)
      visit word_path(word1)
      click_link "Update Content"
      fill_in("Definition", with: "randumb new definition")
      click_button("Update Word")

      expect(page).to have_content "randumb new definition"
      expect(page).to have_content word1.word
      expect(page).to have_link "Update Content"
    end
  end

  context "As an authenticated user who did not create the word" do
    scenario "I should not be able to see the update link" do
      login_as(user[1], scope: :user)
      visit word_path(word1)

      expect(page).to_not have_button "Update Word"
    end
  end

  context "As an unauthenticated user" do
    scenario "I should not be able to see the update link" do
      visit word_path(word1)

      expect(page).to_not have_button "Update Word"
    end
  end
end
