require 'rails_helper'

feature "Word has creators name next to it" do
  let!(:user1) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user1) }
  let!(:word2) { FactoryGirl.create(:word, user: user1) }

  context "A user visits a word page and" do
    scenario "sees their username, if they submitted the word" do
      login_as(user1, scope: :user)
      visit word_path(word1)

      expect(page.find("#word_user")).to have_link(user1.username)
    end

    scenario "sees the username of the user who submitted the word" do
      login_as(user2, scope: :user)
      visit word_path(word1)

      expect(page.find("#word_user")).to have_link(user1.username)
    end
  end
end
