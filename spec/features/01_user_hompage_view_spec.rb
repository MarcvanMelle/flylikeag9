require 'rails_helper'

feature "user visits homepage" do
  context "and as a user" do
    scenario "I can see a list of the 10 most recently made words" do
      user = FactoryGirl.create(:user)
      wordlist = FactoryGirl.create_list(:word, 15, user: user)

      visit '/'

      expect(page).to have_content(wordlist[-1].word)
      expect(page).to have_no_content(wordlist[1].word)
    end
  end
end
