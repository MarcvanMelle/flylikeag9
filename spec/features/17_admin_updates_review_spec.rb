require 'rails_helper'

feature "Admin can update review" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:word) { FactoryGirl.create(:word, user: users[0]) }
  let!(:review) { FactoryGirl.create(:review, user: users[1], word: word) }

  context "As an admin" do
    scenario "I can update a review's body" do
      login_as(admin, scope: :user)
      visit word_path(word)

      click_link "Edit Review"
      fill_in("Review Text", with: "#{review.body} Updated at 10:30pm")
      click_button "Save Review"
      expect(page).to have_content "#{review.body} Updated at 10:30pm"
    end

    scenario "I cannot update a review's rating" do
      login_as(admin, scope: :user)
      visit word_path(word)

      click_link "Edit Review"
      expect(page).to have_no_content "Rating"
    end
  end

  context "As non-admin authenticated user" do
    scenario "I cannot curl into the review update action" do
      login_as(users[0], scope: :user)
      page.driver.submit :patch, "/words/#{word.id}/reviews/#{review.id}", { review: { body: "I'm a hacker. I hacked your review, sucka" } }

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end
end
