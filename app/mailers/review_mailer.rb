class ReviewMailer < ApplicationMailer
  def review_notification(user, word)
    @user = user
    @word = word
    @url  = "https://peaceful-oasis-18076.herokuapp.com/words/#{word.id}"
    mail(to: @user.email, subject: 'You have a new review!')
  end
end
