require 'rails_helper'

feature "User can see favorite word on their profile page" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user1) }
  let!(:word2) { FactoryGirl.create(:word, user: user1) }


  context "A user can visit a profile page" do
    scenario "and see their favorite word, if it is their profile" do
      login_as(user1, scope: :user)
      user1.update(favorite_word_id: word1.id)
      visit user_path(user1)

      expect(page).to have_content("Favorite Word: #{word1.word}")
      expect(page).to_not have_content("Favorite Word: #{word2.word}")
      expect(page).to have_link("Remove Favorite Word")
    end

    scenario "and removed their favorite word" do
      login_as(user1, scope: :user)
      user1.update(favorite_word_id: word1.id)
      visit user_path(user1)

      click_link("Remove Favorite Word")
      user1.update(favorite_word_id: nil)
      visit user_path(user1)

      expect(page).to_not have_content("Favorite Word: #{word1.word}")
      expect(page).to_not have_link("Remove Favorite Word")
    end
  end

  context "A user can visit a profile page" do
    scenario "and see that user's favorite word" do
      login_as(user2, scope: :user)
      user1.update(favorite_word_id: word1.id)
      visit user_path(user1)

      expect(page).to have_content("Favorite Word: #{word1.word}")
      expect(page).to_not have_content("Favorite Word: #{word2.word}")
      expect(page).to_not have_link("Remove Favorite Word")
    end

    scenario "and cannot removed another user's favorite word" do
      login_as(user2, scope: :user)
      user1.update(favorite_word_id: word1.id)
      visit user_path(user1)

      expect(page).to_not have_link("Remove Favorite Word")
    end
  end

end
