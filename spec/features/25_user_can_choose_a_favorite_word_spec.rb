require 'rails_helper'

feature "User can choose a favorite word" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:word) { FactoryGirl.create(:word, user: user) }

  context "As a person" do
    scenario "I can sign in and choose a favorite word" do
      login_as(user, scope: :user)
      visit word_path(word)

      expect(page).to have_button("Favorite Word")
      click_button("Favorite Word")
      user.update(favorite_word_id: word.id)
      visit word_path(word)
      expect(page).to have_content("Favorited")
    end

    scenario "I can sign in and unfavorite a word once I have favorited it" do
      login_as(user, scope: :user)
      visit word_path(word)

      expect(page).to have_button("Favorite Word")
      click_button("Favorite Word")
      user.update(favorite_word_id: word.id)
      visit word_path(word)
      expect(page).to have_content("Favorited")
      expect(page).to have_button("Unfavorite Word")
      click_button("Unfavorite Word")
      user.update(favorite_word_id: nil)
      visit word_path(word)
      expect(page).to have_button("Favorite Word")
    end

    scenario "I do not have access to favoriting a word" do
      visit word_path(word)

      expect(page).to_not have_button("Favorite Word")
      expect(page).to_not have_button("Unfavorite Word")
    end
  end
end
