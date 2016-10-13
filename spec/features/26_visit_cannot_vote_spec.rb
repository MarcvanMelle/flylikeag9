require 'rails_helper'

feature "User can vote on a review" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:word) { FactoryGirl.create(:word, user: user1) }
  let!(:review) { FactoryGirl.create(:review, word: word, user: user2) }
  let!(:review2) { FactoryGirl.create(:review, word: word, user: user1) }
  let!(:vote1) { FactoryGirl.create(:vote, user: user2, review: review2, up_down: "true") }

  before { visit word_path(word) }

  context "A guest visits a word's page" do
    scenario "I cannot see vote buttons on any review" do
      expect(page).to_not have_button("Up")
      expect(page).to_not have_button("Down")
    end
  end
end
