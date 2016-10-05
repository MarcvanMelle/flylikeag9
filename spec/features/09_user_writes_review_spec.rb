require 'rails_helper'

feature "User can write review" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:word1) { FactoryGirl.create(:word, user: user) }
  before { visit word_path(word1) }

  context "As an authenticated user" do
    scenario "I can write a review from a word's show page" do
      login_as(user, scope: :user)
      visit word_path(word1)
      select("1", from: "Rating")
      fill_in("Write Review", with: "This is the worst most awful word I have ever read")
      click_button("Submit Review")

      expect(page).to have_field "Write Review"
      expect(page).to have_button "Submit Review"
      expect(page).to have_content "This is the worst most awful word I have ever read"
    end
  end

   context "As an unauthenticated user" do
     scenario "I should not be able to see the Write Review field or the Submit Review button" do
      visit word_path(word1)

      expect(page).to_not have_field "Write Review"
      expect(page).to_not have_button "Submit Review"
     end
   end
end
