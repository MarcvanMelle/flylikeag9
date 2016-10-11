class ReviewMailer < ApplicationMailer

  def review_notification(user)
    @user = user
    @url  = 'http://localhost:3000/'
    mail(to: @user.email, subject: 'You have a new review!')
  end
end
