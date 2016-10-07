require 'rails_helper'

feature "User can add a word" do
  let!(:user) { FactoryGirl.create(:user) }
  before { login_as(user, scope: :user) }

  context "As a User" do
    scenario "I can navigate to the new word page from the home page" do
      visit root_path
      click_link "Add a new word"

      expect(page).to have_content "Add a new word"
      expect(page).to have_field "Word"
      expect(page).to have_field "Definition"
      expect(page).to have_button "Create Word"
    end

    scenario "I can fill out the form for a new word and submit it successfully" do
      visit new_word_path
      fill_in("Word", with: "Werd")
      fill_in("Definition", with: "A cooler way of saying 'word'.")
      click_button("Create Word")

      expect(page).to have_link "Werd"
      expect(page).to have_content "Word up!"
    end

    scenario "I see an error if I dont fill in the word field" do
      visit new_word_path
      fill_in("Definition", with: "A cooler way of saying 'word'.")
      click_button("Create Word")

      expect(page).to have_content "Word could not be created"
    end

    scenario "I see an error if I dont fill in the definition field" do
      visit new_word_path
      fill_in("Word", with: "Werd")
      click_button("Create Word")

      expect(page).to have_content "Word could not be created"
    end
  end

  context "As a guest" do
    scenario "I receive an error message if I try to add a new word" do
      logout(:user)
      visit root_path

      click_link "Add a new word"

      expect(page).to have_content "You must be logged in to create a word."
    end
  end
end
