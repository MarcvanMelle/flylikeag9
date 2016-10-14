require 'rails_helper'

feature "User profile page" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:not_user) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user) }
  let!(:word2) { FactoryGirl.create(:word, user: not_user) }
  let!(:review1) { FactoryGirl.create(:review, user: user, word: word1) }
  let!(:review2) { FactoryGirl.create(:review, rating: 2, user: not_user, word: word2) }
  let!(:review3) { FactoryGirl.create(:review, rating: 2, user: not_user, word: word2) }
  let!(:review4) { FactoryGirl.create(:review, rating: 2, user: not_user, word: word2) }
  let!(:review5) { FactoryGirl.create(:review, rating: 2, user: not_user, word: word2) }
  let!(:review6) { FactoryGirl.create(:review, rating: 2, user: not_user, word: word2) }
  let!(:vote1) { FactoryGirl.create(:vote, review: review1, user: user, up_down: true, created_at: Date.new(2012, 12, 3)) }
  let!(:vote2) { FactoryGirl.create(:vote, review: review2, user: user, up_down: true) }
  let!(:vote3) { FactoryGirl.create(:vote, review: review3, user: user, up_down: true) }
  let!(:vote4) { FactoryGirl.create(:vote, review: review4, user: user, up_down: true) }
  let!(:vote5) { FactoryGirl.create(:vote, review: review5, user: user, up_down: true) }
  let!(:vote6) { FactoryGirl.create(:vote, review: review6, user: user, up_down: true) }

  before { login_as(user, scope: :user) }
  before { visit user_path(user) }

  context "As a user, I can navigate to my profile" do
    scenario "by clicking a link on the home page" do
      visit root_path
      click_link("My Profile")

      expect(page).to have_content("#{user.username}'s Profile Page")
      expect(page).to have_content("Submitted Reviews")
      expect(page).to have_content("Submitted Words")
    end

    scenario "I should see all of my words and reviews" do
      expect(page).to have_link(word1.word)
      expect(page).to have_content(review1.word.word)
      expect(page).to have_content(review1.rating)
      expect(page).to have_content(review1.body)
    end

    scenario "I should not see words and reviews that are not mine" do
      expect(page.find("#submitted_reviews")).to_not have_link(word2.word)
      expect(page.find("#submitted_reviews")).to_not have_content(review2.body)
    end

    scenario "I should be able to navigate to one of my words by clicking on its link on my profile" do
      click_link("word#{word1.id}")
      expect(page).to have_content word1.word
      expect(page).to have_content word1.definition
    end

    scenario "I should be able to click link to update a chosen word" do
      click_link("Update #{word1.word}")
      expect(page).to have_content word1.word
      expect(page).to have_field "Definition"
      expect(page).to have_button "Update Word"
    end

    scenario "I cannot update words belonging to other users" do
      visit user_path(not_user)
      expect(page).to have_link(word2.word)
      expect(page).to_not have_link("Update #{word2.word}")
    end

    scenario "I should be able to see my 5 most recent votes" do
      visit user_path(user)
      expect(page.find("#last_five_votes")).to_not have_content(user.votes[0].review.body)
      expect(page.find("#last_five_votes")).to have_content(user.votes[1].review.body)
      expect(page.find("#last_five_votes")).to have_content(user.votes[2].review.body)
      expect(page.find("#last_five_votes")).to have_content(user.votes[3].review.body)
      expect(page.find("#last_five_votes")).to have_content(user.votes[4].review.body)
      expect(page.find("#last_five_votes")).to have_content(user.votes[5].review.body)
    end
  end
end
