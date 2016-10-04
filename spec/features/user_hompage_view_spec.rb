require 'rails_helper'
require 'factory_girl'
require_relative '../support/factories'

feature "user visits homepage" do
  let!(:wordlist) { FactoryGirl.create_list(:word, 15) }
  context "and as a user" do
    scenario "I can see a list of the 10 most recently made words" do
      visit '/'

      expect(page).to have_content("Word15")
      expect(page).to have_no_content("Word2")
    end
  end
end
