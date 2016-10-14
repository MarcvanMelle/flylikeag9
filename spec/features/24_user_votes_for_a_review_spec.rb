require 'rails_helper'

feature "User can vote on a review" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:word) { FactoryGirl.create(:word, user: user1) }
  let!(:review) { FactoryGirl.create(:review, word: word, user: user2) }
  let!(:review2) { FactoryGirl.create(:review, word: word, user: user1) }
  let!(:vote1) { FactoryGirl.create(:vote, user: user2, review: review2, up_down: "true") }

  before { login_as(user1, scope: :user) }
  before { visit word_path(word) }

  context "A user visits a word's page" do
    scenario "I can see unique vote buttons associated with a review on the word" do
      expect(page).to have_button("Up")
      expect(page).to have_button("Down")

      expect(page.find("#up#{review.id}")['class']).to eq("btn ")
      expect(page.find("#down#{review.id}")['class']).to eq("btn ")

      expect(page.find("#up#{review2.id}")['class']).to eq("btn ")
      expect(page.find("#down#{review2.id}")['class']).to eq("btn ")
    end

    scenario "I can see an accurate vote-count associate with each review on the word" do
      expect(page.find("#count#{review.id}").text).to eq("Review Score: 0")
      expect(page.find("#count#{review2.id}").text).to eq("Review Score: 1")
    end
  end

  context "A user votes on a review" do
    scenario "I can click on the upvote button of a specific review, and the vote-count and vote buttons update" do
      FactoryGirl.create(:vote, user: user1, review: review, up_down: "true")
      visit word_path(word)
      expect(page.find("#up#{review.id}")['class']).to eq("btn upvoted")
      expect(page.find("#count#{review.id}").text).to eq("Review Score: 1")
    end

    scenario "I can click on the downvote button of a specific review, and the vote-count and vote buttons update" do
      FactoryGirl.create(:vote, user: user1, review: review, up_down: "false")
      visit word_path(word)
      expect(page.find("#down#{review.id}")['class']).to eq("btn downvoted")
      expect(page.find("#count#{review.id}").text).to eq("Review Score: -1")
    end
  end
end
