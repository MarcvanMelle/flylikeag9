require 'rails_helper'

feature "Review has creators name next to it" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user1) }
  let!(:word2) { FactoryGirl.create(:word, user: user1) }
  let!(:review1) { FactoryGirl.create(:review, user: user1, word: word1) }
  let!(:review2) { FactoryGirl.create(:review, user: user2, word: word1) }

  context "A user visits a word page and" do
    scenario "sees the username of the reviewer next to their review" do
      login_as(user1, scope: :user)
      visit word_path(word1)

      expect(page.find("#review_user#{review1.id}")).to have_link(user1.username)
      expect(page.find("#review_user#{review2.id}")).to have_link(user2.username)
    end
  end
end
