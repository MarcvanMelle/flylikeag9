require 'rails_helper'

feature "An admin can delete a review" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:users) { FactoryGirl.create_list(:user, 2) }
  let!(:word) { FactoryGirl.create(:word, user: users[0]) }
  let!(:review) { FactoryGirl.create(:review, user: users[1], word: word) }

  context "As an admin" do
    scenario "I can delete a review" do
      login_as(admin, scope: :user)
      visit word_path(word)

      click_link "Delete Review"
      expect(page).to have_no_content review.body
    end
  end

  context "As non-admin authenticated user" do
    scenario "I cannot curl into the review delete action" do
      login_as(users[0], scope: :user)
      page.driver.submit :delete, "/words/#{word.id}/reviews/#{review.id}", {}

      expect(page).to have_content "You do not have permission to access this page!"
    end
  end
end
