require 'rails_helper'

feature "User updates review" do
  let!(:user) { FactoryGirl.create_list(:user, 2) }
  let!(:word) { FactoryGirl.create(:word, user: user[0]) }
  let!(:review) { FactoryGirl.create(:review, word: word, user: user[0]) }
  before { visit word_path(word) }

  context "As an authenticated user" do
    scenario "I can update a review for a word on the word's show page" do
      login_as(user[0], scope: :user)
      visit word_path(word)
      click_link "Edit Review"
      select("5", from: "Rating")
      fill_in("Review Text", with: "This is the best most awesome word I have ever read")
      click_button "Save Review"

      expect(page).to have_content "This is the best most awesome word I have ever read"
    end
  end

  context "As an unauthenticated user" do
    scenario "I cannot see the Edit Review link" do
      visit word_path(word)

      expect(page).to_not have_link "Edit Review"
    end
  end

  context "As an authenticated user that is not the author" do
    scenario "I cannot see the Edit Review link" do
      login_as(user[1], scope: :user)
      visit word_path(word)

      expect(page).to_not have_link "Edit Review"
    end
  end
end
