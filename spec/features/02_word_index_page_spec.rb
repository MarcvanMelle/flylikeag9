require 'rails_helper'

feature "user visits the words' index page" do
  context "and as a user" do
    scenario "I can see a list of the 20 most recently made words" do
      user = FactoryGirl.create(:user)
      wordlist = FactoryGirl.create_list(:word, 50, user: user)
      visit '/words'

      expect(page).to have_content(wordlist[-1].word)
      expect(page).to have_no_content(wordlist[0].word)
    end

    scenario "I can click next and see the next 25 words on the page" do
      user = FactoryGirl.create(:user)
      wordlist = FactoryGirl.create_list(:word, 50, user: user)
      visit '/words'
      click_link 'Next'

      expect(page).to have_content(wordlist[-27].word)
      expect(page).to have_no_content(wordlist[-1].word)
      expect(page).to have_no_content(wordlist[-10].word)
    end
  end
end
