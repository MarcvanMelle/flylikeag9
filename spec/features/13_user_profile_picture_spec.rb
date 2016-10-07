require 'rails_helper'

feature "The User profile picture" do
  context "Located on the user profile page where" do
    scenario "User can upload a profile picture when signing up" do
      visit root_path
      click_link("Sign up")
      fill_in("Username", with: "ButtonBoy02")
      fill_in("Email", with: "grapesApedude@gmail.com")
      fill_in("Password", with: "abcedf")
      fill_in("Password confirmation", with: "abcedf")
      attach_file "user_avatar", "#{Rails.root}/spec/support/images/myfile.jpg"
      click_button("Sign up")
      click_link("My Profile")

      expect(page).to have_css("img[src*='/uploads/user/avatar/1/thumb_myfile.jpg']")
    end

    scenario "User gets a default profile picture if they didn't upload one" do
      user = FactoryGirl.create(:user, avatar: nil)
      login_as(user, scope: :user)
      visit user_path(user)

      expect(page).to have_css("img[src*='/assets/Man_Silhouette-7f29be934ab1ff88eb44399ee58e4bfda97efdf0b61ea3d17e11bf69d61bc080.jpg']")
    end

    scenario "User updates their own profile picture" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)
      visit user_path(user)
      click_link("Update Profile Picture")
      attach_file "user_avatar", "#{Rails.root}/spec/support/images/myfile2.jpg"
      click_button("Update Profile Picture")

      expect(page).to have_css("img[src*='/uploads/user/avatar/1/thumb_myfile2.jpg']")
    end

    scenario "User can't update another user's profile picture" do
      user = FactoryGirl.create_list(:user, 2)
      login_as(user[0], scope: :user[0])
      visit user_path(user[1])

      expect(page).to_not have_link("Update Profile Picture")
    end

    scenario "User can upload a profile picture from the default picture" do
      user = FactoryGirl.create(:user, avatar: nil)
      login_as(user, scope: :user)
      visit user_path(user)
      click_link("Update Profile Picture")
      attach_file "user_avatar", "#{Rails.root}/spec/support/images/myfile2.jpg"
      click_button("Update Profile Picture")

      expect(page).to have_css("img[src*='/uploads/user/avatar/1/thumb_myfile2.jpg']")
    end

    scenario "User can delete their own profile picture" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)
      visit user_path(user)
      click_link("Delete Profile Picture")

      expect(page).to have_css("img[src*='/assets/Man_Silhouette-7f29be934ab1ff88eb44399ee58e4bfda97efdf0b61ea3d17e11bf69d61bc080.jpg']")
    end

    scenario "If a user has a default profile picture they do not have a delete option" do
      user = FactoryGirl.create(:user, avatar: nil)
      login_as(user, scope: :user)
      visit user_path(user)

      expect(page).to_not have_link("Delete Profile Picture")
    end

    scenario "User can't delete another user's profile picture" do
      user = FactoryGirl.create_list(:user, 2)
      login_as(user[0], scope: :user[0])
      visit user_path(user[1])

      expect(page).to_not have_link("Delete Profile Picture")
    end
  end
end
