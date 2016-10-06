require 'rails_helper'

feature "Admin can update word" do
  let!(:admin) { FactoryGirl.create(:admin) }
  let!(:users) { FactoryGirl.create_list(:user, 4) }
  let!(:words) { FactoryGirl.create_list(:word, 4, user: users[0]) }
  let!(:safe_word) { FactoryGirl.create(:word, user: users[3]) }
  let!(:safe_review) { FactoryGirl.create(:review, user: users[2], word: safe_word) }
  let!(:reviews) { FactoryGirl.create_list(:review, 4, user: users[0], word: words[0]) }
  let!(:reviews) { FactoryGirl.create_list(:review, 4, user: users[0], word: safe_word) }

  context "As an admin" do
    scenario "I can delete a user from the user's profile page" do
      login_as(admin, scope: :user)
      visit user_path(users[0])
      deleted_username = users[0].username

      click_link "Delete User Account"

      expect(page).to have_no_link deleted_username
    end

    scenario "Deleting a user deletes all their words" do
      login_as(admin, scope: :user)
      visit user_path(users[0])
      deleted_words =  users[0].words

      click_link "Delete User Account"

      visit root_path
      deleted_words.each do |word|
        expect(page).to have_no_link word.word
      end
    end

    scenario "Deleting a user deletes all their reviews" do
      login_as(admin, scope: :user)
      visit user_path(users[0])
      deleted_reviews = users[0].reviews

      click_link "Delete User Account"

      visit word_path(safe_word)
      expect(page).to have_content safe_review.body
      deleted_reviews.each do |review|
        expect(page).to have_content review.body
      end
    end
  end
end
